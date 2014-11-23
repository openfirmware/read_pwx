require 'spec_helper'
require 'read_pwx'

RSpec.describe ReadPWX::AthleteParser do
  let(:file) { IO.read(File.join('spec', 'fixtures', 'test_ride.pwx')) }
  let(:node) { Nokogiri::XML(file).xpath('/xmlns:pwx/xmlns:workout/xmlns:athlete') }

  it "creates with an XML node" do
    expect {
      ReadPWX::AthleteParser.new(node)
    }.to_not raise_error
  end

  describe "parsing" do
    let(:parsed) { ReadPWX::AthleteParser.new(node) }

    it "creates an athlete instance" do
      expect(parsed.athlete).to be_kind_of(ReadPWX::PWX::Athlete)
    end

    describe "the athlete instance" do
      let(:athlete) { parsed.athlete }

      it "has the correct name" do
        expect(athlete.name).to eq "unknown"
      end

      it "has the correct weight" do
        expect(athlete.weight).to eq "68.0"
      end
    end
  end
end
