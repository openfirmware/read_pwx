module ReadPWX
  # Parse Athlete details from an XML node
  class AthleteParser
    attr_reader :athlete

    def initialize(node)
      @document = node
      @athlete = PWX::Athlete.new({
        name: name,
        weight: weight
      })
    end

    def name
      @document.at_xpath('xmlns:name').text.strip
    end

    def weight
      @document.at_xpath('xmlns:weight').text.strip
    end
  end
end
