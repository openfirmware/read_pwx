module ReadPWX::PWX
  class Segment
    attr_reader :name, :summary_data

    def initialize(options = {})
      @name = options[:name]
      @summary_data = options[:summary_data]
    end
  end
end
