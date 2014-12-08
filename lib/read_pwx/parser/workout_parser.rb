module ReadPWX
  # Parse Workout details from an XML node
  class WorkoutParser
    attr_reader :workout

    def initialize(node)
      @document = node
      @workout = PWX::Workout.new({
        athlete: athlete,
        cmt: cmt,
        code: code,
        device: device,
        extension: extension,
        fingerprint: fingerprint,
        samples: samples,
        segments: segments,
        sport_type: sport_type,
        summary_data: summary_data,
        time: time,
        title: title
      })
    end

    def athlete
      node = @document.xpath('xmlns:athlete')
      AthleteParser.new(node).athlete
    end

    def device
      node = @document.xpath('xmlns:device')
      DeviceParser.new(node).device
    end

    def extension
      node = @document.xpath('xmlns:extension')
      ExtensionParser.new(node).extension
    end

    def samples
      nodes = @document.xpath('xmlns:sample')
      nodes.map do |node|
        SampleParser.new(node, time).sample
      end
    end

    def segments
      nodes = @document.xpath('xmlns:segment')
      nodes.map do |node|
        SegmentParser.new(node).segment
      end
    end

    def summary_data
      node = @document.xpath('xmlns:summarydata')
      SummaryDataParser.new(node).summary_data
    end

    def cmt
      @document.xpath('xmlns:cmt').text.strip
    end

    def code
      @document.xpath('xmlns:code').text.strip
    end

    def fingerprint
      @document.xpath('xmlns:fingerprint').text.strip
    end

    def sport_type
      @document.xpath('xmlns:sportType').text.strip
    end

    def time
      @document.xpath('xmlns:time').text.strip
    end

    def title
      @document.xpath('xmlns:title').text.strip
    end

  end
end
