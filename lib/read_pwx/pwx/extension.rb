module ReadPWX::PWX
  # Extension refers to unrestricted additional elements that can be added to
  # PWX elements.
  class Extension
    attr_reader :data

    def initialize(options = {})
      @data = options
    end

    def to_hash
      @data
    end

    def [](key)
      @data[key]
    end
  end
end
