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
        cmt: cmt,
        code: code,
        device: PWX::Device.new({
          elevation_change_setting: device_elevation_change_setting,
          id: device_id,
          make: device_make,
          model: device_model,
          stop_detection_setting: device_stop_detection_setting
        }),
        fingerprint: fingerprint,
        sport_type: sport_type,
        summary_data: PWX::SummaryData.new({
          alt: summary_alt,
          beginning: summary_beginning,
          cad: summary_cad,
          climbing_elevation: summary_climbing_elevation,
          descending_elevation: summary_descending_elevation,
          dist: summary_dist,
          duration: summary_duration,
          duration_stopped: summary_duration_stopped,
          hr: summary_hr,
          normalized_power: summary_normalized_power,
          pwr: summary_pwr,
          spd: summary_spd,
          temp: summary_temp,
          torq: summary_torq,
          tss: summary_tss,
          variability_index: summary_variability_index,
          work: summary_work
        }),
        time: time,
        title: title
      })
    end

    def athlete_name
      @document.xpath('/xmlns:pwx/xmlns:workout/xmlns:athlete/xmlns:name').text.strip
    end

    def athlete_weight
      @document.xpath('/xmlns:pwx/xmlns:workout/xmlns:athlete/xmlns:weight').text.strip
    end

    def cmt
      @document.xpath('/xmlns:pwx/xmlns:workout/xmlns:cmt').text.strip
    end

    def code
      @document.xpath('/xmlns:pwx/xmlns:workout/xmlns:code').text.strip
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

    def summary_alt
      @document.xpath('/xmlns:pwx/xmlns:workout/xmlns:summarydata/xmlns:alt').text.strip
    end

    def summary_beginning
      @document.xpath('/xmlns:pwx/xmlns:workout/xmlns:summarydata/xmlns:beginning').text.strip
    end

    def summary_cad
      @document.xpath('/xmlns:pwx/xmlns:workout/xmlns:summarydata/xmlns:cad').text.strip
    end

    def summary_climbing_elevation
      @document.xpath('/xmlns:pwx/xmlns:workout/xmlns:summarydata/xmlns:climbingelevation').text.strip
    end

    def summary_descending_elevation
      @document.xpath('/xmlns:pwx/xmlns:workout/xmlns:summarydata/xmlns:descendingelevation').text.strip
    end

    def summary_dist
      @document.xpath('/xmlns:pwx/xmlns:workout/xmlns:summarydata/xmlns:dist').text.strip
    end

    def summary_duration
      @document.xpath('/xmlns:pwx/xmlns:workout/xmlns:summarydata/xmlns:duration').text.strip
    end

    def summary_duration_stopped
      @document.xpath('/xmlns:pwx/xmlns:workout/xmlns:summarydata/xmlns:durationstopped').text.strip
    end

    def summary_hr
      @document.xpath('/xmlns:pwx/xmlns:workout/xmlns:summarydata/xmlns:hr').text.strip
    end

    def summary_normalized_power
      @document.xpath('/xmlns:pwx/xmlns:workout/xmlns:summarydata/xmlns:normalizedPower').text.strip
    end

    def summary_pwr
      @document.xpath('/xmlns:pwx/xmlns:workout/xmlns:summarydata/xmlns:pwr').text.strip
    end

    def summary_spd
      @document.xpath('/xmlns:pwx/xmlns:workout/xmlns:summarydata/xmlns:spd').text.strip
    end

    def summary_temp
      @document.xpath('/xmlns:pwx/xmlns:workout/xmlns:summarydata/xmlns:temp').text.strip
    end

    def summary_torq
      @document.xpath('/xmlns:pwx/xmlns:workout/xmlns:summarydata/xmlns:torq').text.strip
    end

    def summary_tss
      @document.xpath('/xmlns:pwx/xmlns:workout/xmlns:summarydata/xmlns:tss').text.strip
    end

    def summary_variability_index
      @document.xpath('/xmlns:pwx/xmlns:workout/xmlns:summarydata/xmlns:variabilityIndex').text.strip
    end

    def summary_work
      @document.xpath('/xmlns:pwx/xmlns:workout/xmlns:summarydata/xmlns:work').text.strip
    end

    def time
      @document.xpath('/xmlns:pwx/xmlns:workout/xmlns:time').text.strip
    end

    def title
      @document.xpath('/xmlns:pwx/xmlns:workout/xmlns:title').text.strip
    end
  end
end
