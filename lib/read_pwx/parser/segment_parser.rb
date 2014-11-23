module ReadPWX
  # Parse Segment details from an XML node
  class SegmentParser
    attr_reader :segment

    def initialize(node)
      @document = node
      @segment = PWX::Segment.new({
        name: name,
        summary_data: summary_data
      })
    end

    def name
      @document.xpath('xmlns:name').text.strip
    end

    def summary_data
      node = @document.xpath('xmlns:summarydata')
      SummaryDataParser.new(node).summary_data
    end
  end
end
