module ReadPWX
  # Parse Summary Data details from an XML node
  class SummaryDataParser
    attr_reader :summary_data

    def initialize(node)
      @document = node
      @summary_data = PWX::SummaryData.new({
        alt: alt,
        beginning: beginning,
        cad: cad,
        climbing_elevation: climbing_elevation,
        descending_elevation: descending_elevation,
        dist: dist,
        duration: duration,
        duration_stopped: duration_stopped,
        hr: hr,
        normalized_power: normalized_power,
        pwr: pwr,
        spd: spd,
        temp: temp,
        torq: torq,
        tss: tss,
        variability_index: variability_index,
        work: work
      })
    end

    def alt
      @document.xpath('xmlns:alt').text.strip
    end

    def beginning
      @document.xpath('xmlns:beginning').text.strip
    end

    def cad
      @document.xpath('xmlns:cad').text.strip
    end

    def climbing_elevation
      @document.xpath('xmlns:climbingelevation').text.strip
    end

    def descending_elevation
      @document.xpath('xmlns:descendingelevation').text.strip
    end

    def dist
      @document.xpath('xmlns:dist').text.strip
    end

    def duration
      @document.xpath('xmlns:duration').text.strip
    end

    def duration_stopped
      @document.xpath('xmlns:durationstopped').text.strip
    end

    def hr
      @document.xpath('xmlns:hr').text.strip
    end

    def normalized_power
      @document.xpath('xmlns:normalizedPower').text.strip
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

    def torq
      @document.xpath('xmlns:torq').text.strip
    end

    def tss
      @document.xpath('xmlns:tss').text.strip
    end

    def variability_index
      @document.xpath('xmlns:variabilityIndex').text.strip
    end

    def work
      @document.xpath('xmlns:work').text.strip
    end

  end
end
