module ReadPWX::PWX
  class PWX
    attr_reader :workouts

    def initialize(workouts: workouts)
      @workouts = workouts
    end
  end
end
