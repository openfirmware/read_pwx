require 'spec_helper'
require 'read_pwx'

RSpec.describe ReadPWX::Serializers::GPXSerializer do
  before do
    file = IO.read(File.join('spec', 'fixtures', 'mod_ride.pwx'))
    @pwx = ReadPWX::Parser.new(file).pwx
  end

  it "dumps using a PWX class" do
    expect {
      ReadPWX::Serializers::GPXSerializer.dump(@pwx)
    }.to_not raise_error
  end

  describe "the dumped GPX document" do
    before do
      @gpx = ReadPWX::Serializers::GPXSerializer.dump(@pwx)
    end

    it "validates against GPX schema" do
      schema = Nokogiri::XML::Schema(IO.read(File.join('spec', 'schemas', 'gpx.xsd')))
      expect(schema.valid?(@gpx)).to be true
    end

    it "has no GPX schema errors" do
      schema = Nokogiri::XML::Schema(IO.read(File.join('spec', 'schemas', 'gpx.xsd')))
      expect(schema.validate(@gpx)).to be_empty
    end

    it "validates against GPXData schema" do
      schema = Nokogiri::XML::Schema(IO.read(File.join('spec', 'schemas', 'gpxdata10.xsd')))
      expect(schema.valid?(@gpx)).to be true
    end

    it "has no GPXData schema errors" do
      schema = Nokogiri::XML::Schema(IO.read(File.join('spec', 'schemas', 'gpxdata10.xsd')))
      expect(schema.validate(@gpx)).to be_empty
    end

    it "has the cadence data as a trkpt extension" do
      cadence = @gpx.at_xpath('//gpx:trkpt/gpx:extensions/xmlns:cadence').text.strip
      expect(cadence).to eq @pwx.workouts.first.samples.first.cad
    end

    it "ignores the cadence element when it is not present" do
      cadence = @gpx.xpath('//gpx:trkpt').last.at_xpath('gpx:extensions/xmlns:cadence')
      expect(cadence).to eq nil
    end

    it "has the distance data as a trkpt extension" do
      distance = @gpx.at_xpath('//gpx:trkpt/gpx:extensions/xmlns:distance').text.strip
      expect(distance).to eq @pwx.workouts.first.samples.first.dist
    end

    it "ignores the distance element when it is not present" do
      distance = @gpx.xpath('//gpx:trkpt').last.at_xpath('gpx:extensions/xmlns:distance')
      expect(distance).to eq nil
    end

    it "has the heart rate data as a trkpt extension" do
      hr = @gpx.at_xpath('//gpx:trkpt/gpx:extensions/xmlns:hr').text.strip
      expect(hr).to eq @pwx.workouts.first.samples.first.hr
    end

    it "ignores the heart rate element when it is not present" do
      hr = @gpx.xpath('//gpx:trkpt').last.at_xpath('gpx:extensions/xmlns:hr')
      expect(hr).to eq nil
    end

    it "has the temperature data as a trkpt extension" do
      temp = @gpx.at_xpath('//gpx:trkpt/gpx:extensions/xmlns:temp').text.strip
      expect(temp).to eq @pwx.workouts.first.samples.first.temp
    end

    it "ignores the temperature element when it is not present" do
      temp = @gpx.xpath('//gpx:trkpt').last.at_xpath('gpx:extensions/xmlns:temp')
      expect(temp).to eq nil
    end
  end
end
