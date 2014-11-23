module ReadPWX::PWX
  class Athlete
    attr_reader :name, :weight

    def initialize(name: name, weight: weight)
      @name = name
      @weight = weight
    end
  end
end
