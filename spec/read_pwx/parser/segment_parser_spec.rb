require 'spec_helper'
require 'read_pwx'

RSpec.describe ReadPWX::SegmentParser do
  let(:file) { IO.read(File.join('spec', 'fixtures', 'test_ride.pwx')) }
  let(:node) {
    Nokogiri::XML(file).xpath('/xmlns:pwx/xmlns:workout/xmlns:segment').first
  }

  it "creates with an XML node" do
    expect {
      ReadPWX::SegmentParser.new(node)
    }.to_not raise_error
  end

  describe "parsing" do
    let(:parsed) { ReadPWX::SegmentParser.new(node) }

    it "creates a segment instance" do
      expect(parsed.segment).to be_kind_of(ReadPWX::PWX::Segment)
    end

    describe "the segment instance" do
      let(:segment) { parsed.segment }

      it "has the correct name" do
        expect(segment.name).to eq "Lap 1"
      end

      it "creates a summary data instance" do
        expect(parsed.summary_data).to be_kind_of(ReadPWX::PWX::SummaryData)
      end

      describe "the summary data instance" do
        let(:summary_data) { parsed.summary_data }

        it "has the correct beginning" do
          expect(summary_data.beginning).to eq "0.000"
        end

        it "has the correct duration" do
          expect(summary_data.duration).to eq "253.200"
        end

        it "has the correct duration stopped" do
          expect(summary_data.duration_stopped).to eq "0.000"
        end

        it "has the correct work" do
          expect(summary_data.work).to eq "205"
        end

        it "has the correct dist" do
          expect(summary_data.dist).to eq "982.00"
        end
      end
    end
  end
end
