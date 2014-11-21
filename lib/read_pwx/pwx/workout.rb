module ReadPWX::PWX
  class Workout
    attr_reader :athlete, :device, :fingerprint, :sport_type, :time

    def initialize(options = {})
      @athlete = options[:athlete]
      @device = options[:device]
      @fingerprint = options[:fingerprint]
      @sport_type = options[:sport_type]
      @time = options[:time]
    end
  end
end
