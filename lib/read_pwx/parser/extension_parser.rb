module ReadPWX
  # Parse Extension details from an XML node
  class ExtensionParser
    attr_reader :extension

    def initialize(node)
      @document = node.first
      @extension = PWX::Extension.new(data)
    end

    # Naive conversion of nodes to a hash
    def data
      return {} if empty?
      @document.element_children.inject({}) do |memo, child|
        memo[child.name] = child.text.strip
        memo
      end
    end

    def empty?
      @document.nil? ||  @document.element_children.nil?
    end
  end
end
