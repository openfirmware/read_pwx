require 'spec_helper'
require 'read_pwx'

RSpec.describe ReadPWX::SampleParser do
  let(:file) { IO.read(File.join('spec', 'fixtures', 'test_ride.pwx')) }
  let(:node) {
    Nokogiri::XML(file).xpath('/xmlns:pwx/xmlns:workout/xmlns:sample').first
  }

  it "creates with an XML node and starting time" do
    expect {
      ReadPWX::SampleParser.new(node, "2012-07-24T18:08:53")
    }.to_not raise_error
  end

  describe "parsing" do
    let(:parsed) { ReadPWX::SampleParser.new(node, "2012-07-24T18:08:53") }

    it "creates a sample instance" do
      expect(parsed.sample).to be_kind_of(ReadPWX::PWX::Sample)
    end

    describe "the sample instance" do
      let(:sample) { parsed.sample }

      it "has the correct time offset" do
        expect(sample.time_offset).to eq "0.000"
      end

      it "has the correct lat" do
        expect(sample.lat).to eq "51.079773"
      end

      it "has the correct lon" do
        expect(sample.lon).to eq "-114.133881"
      end

      it "has the correct alt" do
        expect(sample.alt).to eq "1101.00"
      end

      it "creates an extension instance" do
        expect(sample.extension).to be_kind_of(ReadPWX::PWX::Extension)
      end

      describe "the extension instance" do
        let(:extension) { sample.extension }

        it "has the correct hrmstatus" do
          expect(extension["hrmstatus"]).to eq "0"
        end

        it "has the correct gpsstatus" do
          expect(extension["gpsstatus"]).to eq "3"
        end

        it "has the correct spdstatus" do
          expect(extension["spdstatus"]).to eq "0"
        end

        it "has the correct pmstatus" do
          expect(extension["pmstatus"]).to eq "0"
        end

        it "has the correct cadstatus" do
          expect(extension["cadstatus"]).to eq "0"
        end
      end
    end
  end
end
