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
end
