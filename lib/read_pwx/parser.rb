module ReadPWX
  # Parse a string of XML into an XML document.
  class Parser
    attr_reader :document

    def initialize(string)
      @document = Nokogiri::XML(string)
    end
  end
end
