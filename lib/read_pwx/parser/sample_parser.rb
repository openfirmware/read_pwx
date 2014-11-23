module ReadPWX
  # Parse Sample details from an XML node
  class SampleParser
    attr_reader :sample

    def initialize(node)
      @document = node
      @sample = PWX::Sample.new({
        alt: alt,
        cad: cad,
        dist: dist,
        extension: extension,
        hr: hr,
        lat: lat,
        lon: lon,
        pwr: pwr,
        spd: spd,
        temp: temp,
        time: time,
        time_offset: time_offset,
        torq: torq
      })
    end

    def alt
      @document.xpath('xmlns:alt').text.strip
    end

    def cad
      @document.xpath('xmlns:cad').text.strip
    end

    def dist
      @document.xpath('xmlns:dist').text.strip
    end

    def extension
      ExtensionParser.new(@document.xpath('xmlns:extension')).extension
    end

    def hr
      @document.xpath('xmlns:hr').text.strip
    end

    def lat
      @document.xpath('xmlns:lat').text.strip
    end

    def lon
      @document.xpath('xmlns:lon').text.strip
    end

    def pwr
      @document.xpath('xmlns:pwr').text.strip
    end

    def spd
      @document.xpath('xmlns:spd').text.strip
    end

    def temp
      @document.xpath('xmlns:temp').text.strip
    end

    def time
      @document.xpath('xmlns:time').text.strip
    end

    def time_offset
      @document.xpath('xmlns:timeoffset').text.strip
    end

    def torq
      @document.xpath('xmlns:torq').text.strip
    end
  end
end
