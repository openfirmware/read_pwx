module ReadPWX::PWX
  class Workout
    attr_reader :athlete, :cmt, :code, :device, :fingerprint, :segments,
                :sport_type, :time, :title, :summary_data

    def initialize(options = {})
      @athlete = options[:athlete]
      @cmt = options[:cmt]
      @code = options[:code]
      @device = options[:device]
      @fingerprint = options[:fingerprint]
      @segments = options[:segments]
      @sport_type = options[:sport_type]
      @summary_data = options[:summary_data]
      @time = options[:time]
      @title = options[:title]
    end
  end
end
