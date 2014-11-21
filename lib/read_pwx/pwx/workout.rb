module ReadPWX::PWX
  class Workout
    attr_reader :athlete, :fingerprint, :sport_type, :time

    def initialize(options = {})
      @athlete = options[:athlete]
      @fingerprint = options[:fingerprint]
      @sport_type = options[:sport_type]
      @time = options[:time]
    end
  end
end
