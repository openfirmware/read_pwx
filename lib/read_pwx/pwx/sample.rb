module ReadPWX::PWX
  class Sample
    attr_reader :alt, :cad, :dist, :extension, :hr, :lat, :lon, :pwr, :spd,
                :temp, :time, :time_offset, :torq

    def initialize(options = {})
      @alt = options[:alt]
      @cad = options[:cad]
      @dist = options[:dist]
      @extension = options[:extension]
      @hr = options[:hr]
      @lat = options[:lat]
      @lon = options[:lon]
      @pwr = options[:pwr]
      @spd = options[:spd]
      @temp = options[:temp]
      @time = options[:time]
      @time_offset = options[:time_offset]
      @torq = options[:torq]
    end
  end
end
