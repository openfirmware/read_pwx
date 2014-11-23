require 'spec_helper'
require 'read_pwx'

RSpec.describe ReadPWX::SampleParser do
  let(:file) { IO.read(File.join('spec', 'fixtures', 'test_ride.pwx')) }
  let(:node) {
    Nokogiri::XML(file).xpath('/xmlns:pwx/xmlns:workout/xmlns:sample').first
  }

  it "creates with an XML node" do
    expect {
      ReadPWX::SampleParser.new(node)
    }.to_not raise_error
  end

  describe "parsing" do
    let(:parsed) { ReadPWX::SampleParser.new(node) }

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
    end
  end
end
