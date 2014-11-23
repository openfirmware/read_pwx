require 'spec_helper'
require 'read_pwx'

RSpec.describe ReadPWX::ExtensionParser do
  let(:file) { IO.read(File.join('spec', 'fixtures', 'test_ride.pwx')) }
  let(:node) { Nokogiri::XML(file).xpath('/xmlns:pwx/xmlns:workout/xmlns:extension') }

  it "creates with an XML node" do
    expect {
      ReadPWX::ExtensionParser.new(node)
    }.to_not raise_error
  end

  describe "parsing" do
    let(:parsed) { ReadPWX::ExtensionParser.new(node) }

    it "creates an extension instance" do
      expect(parsed.extension).to be_kind_of(ReadPWX::PWX::Extension)
    end

    describe "the extension instance" do
      let(:extension) { parsed.extension }

      it "has the correct laps count" do
        expect(extension["laps"]).to eq "1"
      end

      it "has the correct ascent" do
        expect(extension["ascent"]).to eq "14"
      end

      it "has the correct descent" do
        expect(extension["descent"]).to eq "0"
      end

      it "has the correct points" do
        expect(extension["points"]).to eq "105"
      end
    end
  end
end
