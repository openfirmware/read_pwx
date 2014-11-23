require 'spec_helper'
require 'read_pwx'

RSpec.describe ReadPWX::DeviceParser do
  let(:sample) { IO.read(File.join('spec', 'fixtures', 'test_ride.pwx')) }
  let(:node) { Nokogiri::XML(sample).xpath('/xmlns:pwx/xmlns:workout/xmlns:device') }

  it "creates with an XML node" do
    expect {
      ReadPWX::DeviceParser.new(node)
    }.to_not raise_error
  end

  describe "parsing" do
    let(:parsed) { ReadPWX::DeviceParser.new(node) }

    it "creates a device instance" do
      expect(parsed.device).to be_kind_of(ReadPWX::PWX::Device)
    end

    describe "the device instance" do
      let(:device) { parsed.device }

      it "has the correct id" do
        expect(device.id).to eq "TESTUSER"
      end

      it "has the correct make" do
        expect(device.make).to eq "Timex"
      end

      it "has the correct model" do
        expect(device.model).to eq "Cycle Trainer"
      end

      it "has the correct stop detection setting" do
        expect(device.stop_detection_setting).to eq "5.000"
      end

      it "has an extension instance" do
        expect(device.extension).to be_kind_of(ReadPWX::PWX::Extension)
      end
    end
  end
end
