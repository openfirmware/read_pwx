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
end
