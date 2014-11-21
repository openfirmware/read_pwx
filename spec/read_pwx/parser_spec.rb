require 'spec_helper'
require 'read_pwx'

RSpec.describe ReadPWX::Parser do
  let(:sample) { IO.read(File.join('spec', 'fixtures', 'test_ride.pwx')) }

  it "creates with an XML string" do
    expect {
      ReadPWX::Parser.new(sample)
    }.to_not raise_error
  end

  it "allows access to the XML document" do
    parsed = ReadPWX::Parser.new(sample)
    expect(parsed.document).to be_kind_of(Nokogiri::XML::Document)
  end

  it "allows validation of itself" do
    parsed = ReadPWX::Parser.new(sample)
    expect(parsed).to respond_to(:valid?)
  end

  it "is valid" do
    parsed = ReadPWX::Parser.new(sample)
    expect(parsed.valid?).to be true
  end

  it "allows inspection of validation errors" do
    parsed = ReadPWX::Parser.new(sample)
    expect(parsed).to respond_to(:validation_errors)
  end

  it "has no validation errors" do
    parsed = ReadPWX::Parser.new(sample)
    expect(parsed.validation_errors).to be_empty
  end
end
