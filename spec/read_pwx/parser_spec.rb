require 'spec_helper'
require 'read_pwx'

RSpec.describe ReadPWX::Parser do
  let(:sample) { IO.read(File.join('spec', 'fixtures', 'test_ride.pwx')) }

  it "creates with an XML string" do
    expect {
      ReadPWX::Parser.new(sample)
    }.to_not raise_error
  end

  describe "parsing" do
    let(:parsed) { ReadPWX::Parser.new(sample) }

    it "allows access to the XML document" do
      expect(parsed.document).to be_kind_of(Nokogiri::XML::Document)
    end

    it "allows validation of itself" do
      expect(parsed).to respond_to(:valid?)
    end

    it "is valid" do
      expect(parsed.valid?).to be true
    end

    it "allows inspection of validation errors" do
      expect(parsed).to respond_to(:validation_errors)
    end

    it "has no validation errors" do
      expect(parsed.validation_errors).to be_empty
    end

    it "has an array of workout instances" do
      expect(parsed.workouts).to be_kind_of(Array)
    end

    it "creates a workout instance" do
      expect(parsed.workouts.first).to be_kind_of(ReadPWX::PWX::Workout)
    end

    describe "the workout instance" do
      let(:workout) { parsed.workouts.first }

      it "has the correct fingerprint" do
        expect(workout.fingerprint).to eq "22d20f5cad9597a49c09974b998e483b392a382d5a42df18679e99da18d44e10"
      end

      it "has the correct sport type" do
        expect(workout.sport_type).to eq "Bike"
      end

      it "has the correct title" do
        expect(workout.title).to eq ""
      end

      it "has the correct cmt" do
        expect(workout.cmt).to eq "Timex Cycle Trainer"
      end

      it "has the correct code" do
        expect(workout.code).to eq ""
      end

      it "has the correct time" do
        expect(workout.time).to eq "2012-07-24T18:08:53"
      end

      it "has an array of segment instances" do
        expect(workout.segments).to be_kind_of(Array)
      end

      it "has an array of sample instances" do
        expect(workout.samples).to be_kind_of(Array)
      end

      it "has an athlete instance" do
        expect(workout.athlete).to be_kind_of(ReadPWX::PWX::Athlete)
      end

      it "has a device instance" do
        expect(workout.device).to be_kind_of(ReadPWX::PWX::Device)
      end

      it "has an extension instance" do
        expect(workout.extension).to be_kind_of(ReadPWX::PWX::Extension)
      end

      it "has a summary data instance" do
        expect(workout.summary_data).to be_kind_of(ReadPWX::PWX::SummaryData)
      end
    end
  end
end
