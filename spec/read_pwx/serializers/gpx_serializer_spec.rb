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

    it "sets the metadata author name" do
      name = @gpx.at_xpath('/xmlns:gpx/xmlns:metadata/xmlns:author/xmlns:name').text.strip
      expect(name).to eq "ReadPWX"
    end

    it "sets the metadata author link text" do
      link = @gpx.at_xpath('/xmlns:gpx/xmlns:metadata/xmlns:author/xmlns:link/xmlns:text').text.strip
      expect(link).to eq "Github: openfirmware/read_pwx"
    end

    it "sets the metadata author link href" do
      link = @gpx.at_xpath('/xmlns:gpx/xmlns:metadata/xmlns:author/xmlns:link')
      expect(link.attributes['href'].value).to eq "https://github.com/openfirmware/read_pwx"
    end

    it "sets the metadata author link mimetype" do
      link = @gpx.at_xpath('/xmlns:gpx/xmlns:metadata/xmlns:author/xmlns:link/xmlns:type').text.strip
      expect(link).to eq "text/html"
    end

    it "has the cadence data as a trkpt extension" do
      cadence = @gpx.at_xpath('//xmlns:trkpt/xmlns:extensions/gpxdata:cadence').text.strip
      expect(cadence).to eq @pwx.workouts.first.samples.first.cad
    end

    it "ignores the cadence element when it is not present" do
      cadence = @gpx.xpath('//xmlns:trkpt').last.at_xpath('xmlns:extensions/gpxdata:cadence')
      expect(cadence).to eq nil
    end

    it "has the distance data as a trkpt extension" do
      distance = @gpx.at_xpath('//xmlns:trkpt/xmlns:extensions/gpxdata:distance').text.strip
      expect(distance).to eq @pwx.workouts.first.samples.first.dist
    end

    it "ignores the distance element when it is not present" do
      distance = @gpx.xpath('//xmlns:trkpt').last.at_xpath('xmlns:extensions/gpxdata:distance')
      expect(distance).to eq nil
    end

    it "has the heart rate data as a trkpt extension" do
      hr = @gpx.at_xpath('//xmlns:trkpt/xmlns:extensions/gpxdata:hr').text.strip
      expect(hr).to eq @pwx.workouts.first.samples.first.hr
    end

    it "ignores the heart rate element when it is not present" do
      hr = @gpx.xpath('//xmlns:trkpt').last.at_xpath('xmlns:extensions/gpxdata:hr')
      expect(hr).to eq nil
    end

    it "has the temperature data as a trkpt extension" do
      temp = @gpx.at_xpath('//xmlns:trkpt/xmlns:extensions/gpxdata:temp').text.strip
      expect(temp).to eq @pwx.workouts.first.samples.first.temp
    end

    it "ignores the temperature element when it is not present" do
      temp = @gpx.xpath('//xmlns:trkpt').last.at_xpath('xmlns:extensions/gpxdata:temp')
      expect(temp).to eq nil
    end

    it "has the power data as a trkpt extension" do
      power = @gpx.at_xpath('//xmlns:trkpt/xmlns:extensions/gpxdata:power').text.strip
      expect(power).to eq @pwx.workouts.first.samples.first.pwr
    end

    it "ignores the power element when it is not present" do
      power = @gpx.xpath('//xmlns:trkpt').last.at_xpath('xmlns:extensions/gpxdata:power')
      expect(power).to eq nil
    end

    it "has the ISO8601 date/time as a trkpt element" do
      datetime = @gpx.at_xpath('//xmlns:trkpt/xmlns:time').text.strip
      expect(datetime).to eq @pwx.workouts.first.samples.first.time
    end

    it "has the run info as a trk extension" do
      run = @gpx.at_xpath('//xmlns:trk/xmlns:extensions/gpxdata:run')
      expect(run).to_not eq nil
    end
  end
end
