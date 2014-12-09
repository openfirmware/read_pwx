module ReadPWX::PWX
  class Athlete
    attr_reader :name, :weight

    def initialize(options = {})
      @name = options[:name]
      @weight = options[:weight]
    end
  end
end
