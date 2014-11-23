require 'spec_helper'
require 'read_pwx'

RSpec.describe ReadPWX::SummaryDataParser do
  let(:sample) { IO.read(File.join('spec', 'fixtures', 'test_ride.pwx')) }
  let(:node) { Nokogiri::XML(sample).xpath('/xmlns:pwx/xmlns:workout/xmlns:summarydata') }

  it "creates with an XML node" do
    expect {
      ReadPWX::SummaryDataParser.new(node)
    }.to_not raise_error
  end

  describe "parsing" do
    let(:parsed) { ReadPWX::SummaryDataParser.new(node) }

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

      it "has the correct dist" do
        expect(summary_data.dist).to eq "982.00"
      end
    end
  end
end
