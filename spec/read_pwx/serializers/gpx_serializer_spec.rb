require 'spec_helper'
require 'read_pwx'

RSpec.describe ReadPWX::Serializers::GPXSerializer do
  before do
    file = IO.read(File.join('spec', 'fixtures', 'test_ride.pwx'))
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
  end
end
