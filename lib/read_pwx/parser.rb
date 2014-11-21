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
  end
end
