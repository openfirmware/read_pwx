module ReadPWX::PWX
  class Workout
    attr_reader :athlete, :device, :fingerprint, :sport_type, :time,
                :summary_data

    def initialize(options = {})
      @athlete = options[:athlete]
      @device = options[:device]
      @fingerprint = options[:fingerprint]
      @sport_type = options[:sport_type]
      @summary_data = options[:summary_data]
      @time = options[:time]
    end
  end
end
