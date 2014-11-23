module ReadPWX::PWX
  class Segment
    attr_reader :name, :summary_data

    def initialize(name: name, summary_data: summary_data)
      @name = name
      @summary_data = summary_data
    end
  end
end
