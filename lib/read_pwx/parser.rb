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
        athlete: athlete,
        cmt: cmt,
        code: code,
        device: device,
        fingerprint: fingerprint,
        sport_type: sport_type,
        summary_data: summary_data,
        time: time,
        title: title
      })
    end

    def athlete
      node = @document.xpath('/xmlns:pwx/xmlns:workout/xmlns:athlete')
      AthleteParser.new(node).athlete
    end

    def device
      node = @document.xpath('/xmlns:pwx/xmlns:workout/xmlns:device')
      DeviceParser.new(node).device
    end

    def summary_data
      node = @document.xpath('/xmlns:pwx/xmlns:workout/xmlns:summarydata')
      SummaryDataParser.new(node).summary_data
    end

    def cmt
      @document.xpath('/xmlns:pwx/xmlns:workout/xmlns:cmt').text.strip
    end

    def code
      @document.xpath('/xmlns:pwx/xmlns:workout/xmlns:code').text.strip
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

    def title
      @document.xpath('/xmlns:pwx/xmlns:workout/xmlns:title').text.strip
    end
  end
end
