module ReadPWX::Serializers
  class GPXSerializer
    class << self
      def dump(pwx)
        builder = Nokogiri::XML::Builder.new do |xml|
          xml.gpx(gpx_attributes) {
            xml.metadata {
              xml.time Time.now.utc.iso8601
              xml.extensions {}
            }

            pwx.workouts.each_with_index do |workout, index|
              xml.trk { # corresponds to workout
                xml.name workout.fingerprint
                xml.src "#{workout.device.make} #{workout.device.model}"
                xml.number index
                xml.extensions {}

                xml.trkseg {
                  workout.samples.each do |sample|
                    if !sample.lat.empty? && !sample.lon.empty?
                      xml.trkpt(lat: sample.lat, lon: sample.lon) {
                        # look into extensions to GPX for HRM, Cadence, etc.

                        xml.ele sample.alt

                        # use time, or calculate from time_offset
                        xml.time (DateTime.strptime(workout.time, "%Y-%m-%dT%H:%I:%S") + sample.time_offset.to_i).iso8601

                        xml.extensions {} # status of devices
                      }
                    end
                  end
                  xml.extensions {} # extensions to segment
                }
              }
            end

            xml.extensions {}
          }
        end

        builder.doc
      end

      private

      def gpx_attributes
        {
          "xmlns" => "http://www.topografix.com/GPX/1/1",
          "xmlns:xsd" => "http://www.w3.org/2001/XMLSchema",
          "creator" => "ReadPWX " + ReadPWX::VERSION,
          "version" => "1.1"
        }
      end
    end
  end
end
