module ReadPWX::PWX
  class PWX
    attr_reader :workouts

    def initialize(options = {})
      @workouts = options[:workouts]
    end
  end
end
