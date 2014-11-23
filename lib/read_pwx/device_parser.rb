module ReadPWX
  # Parse Device details from an XML node
  class DeviceParser
    attr_reader :device

    def initialize(node)
      @document = node
      @device = PWX::Device.new({
        elevation_change_setting: elevation_change_setting,
        id: id,
        make: make,
        model: model,
        stop_detection_setting: stop_detection_setting
      })
    end

    def elevation_change_setting
      @document.xpath('xmlns:elevationchangesetting').text.strip
    end

    def id
      @document.attribute('id').value
    end

    def make
      @document.xpath('xmlns:make').text.strip
    end

    def model
      @document.xpath('xmlns:model').text.strip
    end

    def stop_detection_setting
      @document.xpath('xmlns:stopdetectionsetting').text.strip
    end
  end
end
