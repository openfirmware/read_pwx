module ReadPWX::PWX
  class Device
    attr_reader :elevation_change_setting, :extension, :id, :make, :model,
                :stop_detection_setting

    def initialize(options = {})
      @elevation_change_setting = options[:elevation_change_setting]
      @extension = options[:extension]
      @id = options[:id]
      @make = options[:make]
      @model = options[:model]
      @stop_detection_setting = options[:stop_detection_setting]
    end
  end
end
