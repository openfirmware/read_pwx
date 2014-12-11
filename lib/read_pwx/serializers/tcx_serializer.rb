module ReadPWX::Serializers
  class TCXSerializer
    class << self
      def dump(pwx)
        Nokogiri::XML::Builder.new(encoding: "UTF-8") { |xml|
          xml.TrainingCenterDatabase(tcx_attributes) {
            xml.Activities {
              pwx.workouts.each do |workout|
                xml.Activity(Sport: tcx_sport_enum(workout.sport_type)) {
                  xml.Id workout.time
                  xml.Lap(StartTime: workout.time) {
                    segment_data = workout.segments.first.summary_data

                    xml.TotalTimeSeconds segment_data.duration
                    xml.DistanceMeters segment_data.dist.to_f
                    # xml.MaximumSpeed needs minMaxAvg support
                    # Convert kJ to calories
                    xml.Calories (segment_data.work.to_f * 238.8458966275).floor
                    # xml.AverageHeartRateBpm needs minMaxAvg support
                    # xml.MaximumHeartRateBpm needs minMaxAvg support
                    xml.Intensity "Active"
                    # xml.Cadence needs minMaxAvg support
                    xml.TriggerMethod "Manual"
                    xml.Track {
                      workout.samples.each do |sample|
                        xml.Trackpoint {
                          xml.Time sample.time
                          xml.Position {
                            xml.LatitudeDegrees sample.lat.to_f
                            xml.LongitudeDegrees sample.lon.to_f
                          }
                          xml.AltitudeMeters sample.alt.to_f
                          xml.DistanceMeters sample.dist.to_f

                          if !sample.hr.empty?
                            xml.HeartRateBpm {
                              xml.Value sample.hr
                            }
                          end

                          xml.Cadence sample.cad if !sample.cad.empty?

                        }
                      end
                    }

                    xml.Notes workout.segments.first.name
                  }

                  dist = workout.summary_data.dist
                  time = DateTime.iso8601(workout.time).to_time.getlocal.to_s
                  xml.Notes "#{workout.sport_type} on #{time} for #{dist}m"
                }
              end
            }
          }
        }.doc
      end

      private

      def tcx_attributes
        {
          "xmlns" => "http://www.garmin.com/xmlschemas/TrainingCenterDatabase/v2",
          "xmlns:xsd" => "http://www.w3.org/2001/XMLSchema",
          "xmlns:tc2" => "http://www.garmin.com/xmlschemas/TrainingCenterDatabase/v2"
        }
      end

      def tcx_sport_enum(sport_type)
        case sport_type
          when "Bike" then 'Biking'
          when "Run" then 'Running'
          else 'Other'
        end
      end
    end
  end
end
