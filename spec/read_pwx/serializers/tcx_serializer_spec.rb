require 'spec_helper'
require 'read_pwx'

RSpec.describe ReadPWX::Serializers::TCXSerializer do
  before do
    file = IO.read(File.join('spec', 'fixtures', 'mod_ride.pwx'))
    @pwx = ReadPWX::Parser.new(file).pwx
  end

  it "dumps using a PWX class" do
    expect {
      ReadPWX::Serializers::TCXSerializer.dump(@pwx)
    }.to_not raise_error
  end

  describe "the dumped TCX document" do
    before do
      @tcx = ReadPWX::Serializers::TCXSerializer.dump(@pwx)
    end

    it "validates against TCX schema" do
      schema = Nokogiri::XML::Schema(IO.read(File.join('spec', 'schemas', 'TrainingCenterDatabasev2.xsd')))
      expect(schema.valid?(@tcx)).to be true
    end

    it "has no TCX schema errors" do
      schema = Nokogiri::XML::Schema(IO.read(File.join('spec', 'schemas', 'TrainingCenterDatabasev2.xsd')))
      expect(schema.validate(@tcx)).to be_empty
    end
  end
end
