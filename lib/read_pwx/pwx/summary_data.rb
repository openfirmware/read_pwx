module ReadPWX::PWX
  class SummaryData
    attr_reader :alt, :beginning, :cad, :climbing_elevation,
                :descending_elevation, :dist, :duration, :duration_stopped,
                :extension, :hr, :normalized_power, :pwr, :spd, :temp, :torq,
                :tss, :variability_index, :work

    def initialize(options = {})
      @alt = options[:alt]
      @beginning = options[:beginning]
      @cad = options[:cad]
      @climbing_elevation = options[:climbing_elevation]
      @descending_elevation = options[:descending_elevation]
      @dist = options[:dist]
      @duration = options[:duration]
      @duration_stopped = options[:duration_stopped]
      @extension = options[:extension]
      @hr = options[:hr]
      @normalized_power = options[:normalized_power]
      @pwr = options[:pwr]
      @spd = options[:spd]
      @temp = options[:temp]
      @torq = options[:torq]
      @tss = options[:tss]
      @variability_index = options[:variability_index]
      @work = options[:work]
    end
  end
end
