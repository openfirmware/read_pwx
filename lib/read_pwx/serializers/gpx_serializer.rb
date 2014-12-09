module ReadPWX::Serializers
  class GPXSerializer
    class << self
      def dump(pwx)
        builder = Nokogiri::XML::Builder.new(encoding: "UTF-8") do |xml|
          xml.gpx(gpx_attributes) {
            xml.metadata {
              xml.author {
                xml.name "ReadPWX"
                xml.link(href: "https://github.com/openfirmware/read_pwx") {
                  xml.text_ "Github: openfirmware/read_pwx"
                  xml.type_ "text/html"
                }
              }
              xml.time Time.now.utc.iso8601
            }

            pwx.workouts.each_with_index do |workout, index|
              xml.trk { # corresponds to workout
                xml.name workout.fingerprint
                xml.src "#{workout.device.make} #{workout.device.model}"
                xml.number index
                xml.type_ workout.sport_type
                xml.extensions {
                  xml['gpxdata'].run {
                    xml['gpxdata'].sport gpx_sport_enum(workout.sport_type)
                    xml['gpxdata'].laps {
                      workout.segments.each_with_index do |segment, index|
                        xml['gpxdata'].lap {
                          xml['gpxdata'].index index
                          xml['gpxdata'].elapsedTime segment.summary_data.duration
                          xml['gpxdata'].distance segment.summary_data.dist
                        }
                      end
                    }
                  }
                }

                xml.trkseg {
                  workout.samples.each do |sample|
                    if !sample.lat.empty? && !sample.lon.empty?
                      xml.trkpt(lat: sample.lat, lon: sample.lon) {
                        xml.ele sample.alt
                        xml.time sample.time

                        xml.extensions {
                          xml['gpxdata'].cadence sample.cad unless sample.cad.empty?
                          xml['gpxdata'].distance sample.dist unless sample.dist.empty?
                          xml['gpxdata'].hr sample.hr unless sample.hr.empty?
                          xml['gpxdata'].power sample.pwr unless sample.pwr.empty?
                          xml['gpxdata'].temp sample.temp unless sample.temp.empty?
                        }
                      }
                    end
                  end
                }
              }
            end
          }
        end

        builder.doc
      end

      private

      def gpx_attributes
        {
          "xmlns" => "http://www.topografix.com/GPX/1/1",
          "xmlns:gpxdata" => "http://www.cluetrust.com/XML/GPXDATA/1/0",
          "xmlns:xsd" => "http://www.w3.org/2001/XMLSchema",
          "creator" => "ReadPWX " + ReadPWX::VERSION,
          "version" => "1.1"
        }
      end

      def gpx_sport_enum(sport_type)
        case sport_type
          when "Bike" then 'bike'
          when "Run" then 'run'
          else 'other'
        end
      end
    end
  end
end
