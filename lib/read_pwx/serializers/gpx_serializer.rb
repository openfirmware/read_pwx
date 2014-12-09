module ReadPWX::Serializers
  class GPXSerializer
    class << self
      def dump(pwx)
        Nokogiri::XML::Builder.new(encoding: "UTF-8") { |xml|
          xml.gpx(gpx_attributes) {
            metadata(xml)

            pwx.workouts.each_with_index do |workout, index|
              trk(xml, workout, index)
            end
          }
        }.doc
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

      def author(xml)
        xml.author {
          xml.name "ReadPWX"
          xml.link(href: "https://github.com/openfirmware/read_pwx") {
            xml.text_ "Github: openfirmware/read_pwx"
            xml.type_ "text/html"
          }
        }
      end

      def metadata(xml)
        xml.metadata {
          author(xml)
          xml.time Time.now.utc.iso8601
        }
      end

      def trk(xml, workout, index)
        xml.trk {
          xml.name trk_name(workout)
          xml.src "#{workout.device.make} #{workout.device.model}"
          xml.number index
          xml.type_ workout.sport_type
          trk_extensions(xml, workout)

          xml.trkseg {
            workout.samples.each do |sample|
              trkpt(xml, sample)
            end
          }
        }
      end

      def trk_extensions(xml, workout)
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
      end

      def trk_name(workout)
        dist = workout.summary_data.dist
        time = DateTime.iso8601(workout.time).to_time.getlocal.to_s
        "#{workout.sport_type} on #{time} for #{dist}m"
      end

      def trkpt(xml, sample)
        if !sample.lat.empty? && !sample.lon.empty?
          xml.trkpt(lat: sample.lat, lon: sample.lon) {
            xml.ele sample.alt
            xml.time sample.time
            trkpt_extensions(xml, sample)
          }
        end
      end

      def trkpt_extensions(xml, sample)
        xml.extensions {
          xml['gpxdata'].cadence sample.cad unless sample.cad.empty?
          xml['gpxdata'].distance sample.dist unless sample.dist.empty?
          xml['gpxdata'].hr sample.hr unless sample.hr.empty?
          xml['gpxdata'].power sample.pwr unless sample.pwr.empty?
          xml['gpxdata'].temp sample.temp unless sample.temp.empty?
        }
      end
    end
  end
end
