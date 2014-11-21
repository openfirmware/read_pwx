module ReadPWX
  # Parse a string of XML into an XML document.
  class Parser
    SCHEMA_PATH = File.join(File.dirname(__FILE__), '..', '..', 'spec', 'schemas', 'pwx.xsd')
    attr_reader :document

    def initialize(string)
      @document = Nokogiri::XML(string)
      @schema = Nokogiri::XML::Schema(IO.read(SCHEMA_PATH))
    end

    def valid?
      @schema.valid?(@document)
    end

    def validation_errors
      @schema.validate(@document)
    end

    def workout
      PWX::Workout.new({
        athlete: PWX::Athlete.new({
          name: athlete_name,
          weight: athlete_weight
        }),
        device: PWX::Device.new({
          elevation_change_setting: device_elevation_change_setting,
          id: device_id,
          make: device_make,
          model: device_model,
          stop_detection_setting: device_stop_detection_setting
        }),
        fingerprint: fingerprint,
        sport_type: sport_type,
        time: time
      })
    end

    def athlete_name
      @document.xpath('/xmlns:pwx/xmlns:workout/xmlns:athlete/xmlns:name').text.strip
    end

    def athlete_weight
      @document.xpath('/xmlns:pwx/xmlns:workout/xmlns:athlete/xmlns:weight').text.strip
    end

    def device_elevation_change_setting
      @document.xpath('/xmlns:pwx/xmlns:workout/xmlns:device/xmlns:elevationchangesetting').text.strip
    end

    def device_id
      @document.xpath('/xmlns:pwx/xmlns:workout/xmlns:device').attribute('id').value
    end

    def device_make
      @document.xpath('/xmlns:pwx/xmlns:workout/xmlns:device/xmlns:make').text.strip
    end

    def device_model
      @document.xpath('/xmlns:pwx/xmlns:workout/xmlns:device/xmlns:model').text.strip
    end

    def device_stop_detection_setting
      @document.xpath('/xmlns:pwx/xmlns:workout/xmlns:device/xmlns:stopdetectionsetting').text.strip
    end

    def fingerprint
      @document.xpath('/xmlns:pwx/xmlns:workout/xmlns:fingerprint').text.strip
    end

    def sport_type
      @document.xpath('/xmlns:pwx/xmlns:workout/xmlns:sportType').text.strip
    end

    def time
      @document.xpath('/xmlns:pwx/xmlns:workout/xmlns:time').text.strip
    end
  end
end
