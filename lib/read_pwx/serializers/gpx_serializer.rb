module ReadPWX::Serializers
  class GPXSerializer
    class << self
      def dump(pwx)
        builder = Nokogiri::XML::Builder.new do |xml|
          xml['gpx'].gpx(gpx_attributes) {
            xml['gpx'].metadata {
              xml['gpx'].time Time.now.utc.iso8601
              xml['gpx'].extensions {}
            }

            pwx.workouts.each_with_index do |workout, index|
              xml['gpx'].trk { # corresponds to workout
                xml['gpx'].name workout.fingerprint
                xml['gpx'].src "#{workout.device.make} #{workout.device.model}"
                xml['gpx'].number index
                xml['gpx'].extensions {}

                xml['gpx'].trkseg {
                  workout.samples.each do |sample|
                    if !sample.lat.empty? && !sample.lon.empty?
                      xml['gpx'].trkpt(lat: sample.lat, lon: sample.lon) {
                        # look into extensions to GPX for HRM, Cadence, etc.

                        xml['gpx'].ele sample.alt

                        # use time, or calculate from time_offset
                        xml['gpx'].time (DateTime.strptime(workout.time, "%Y-%m-%dT%H:%I:%S") + sample.time_offset.to_i).iso8601

                        xml['gpx'].extensions {
                          xml.cadence sample.cad unless sample.cad.empty?
                          xml.distance sample.dist unless sample.dist.empty?
                          xml.hr sample.hr unless sample.hr.empty?
                          xml.power sample.pwr unless sample.pwr.empty?
                          xml.temp sample.temp unless sample.temp.empty?
                        } # status of devices
                      }
                    end
                  end
                  xml['gpx'].extensions {} # extensions to segment
                }
              }
            end

            xml['gpx'].extensions {}
          }
        end

        builder.doc
      end

      private

      def gpx_attributes
        {
          "xmlns" => "http://www.cluetrust.com/XML/GPXDATA/1/0",
          "xmlns:gpx" => "http://www.topografix.com/GPX/1/1",
          "xmlns:xsd" => "http://www.w3.org/2001/XMLSchema",
          "creator" => "ReadPWX " + ReadPWX::VERSION,
          "version" => "1.1"
        }
      end
    end
  end
end
