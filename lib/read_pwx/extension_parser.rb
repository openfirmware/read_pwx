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
      @document.element_children.inject({}) do |memo, child|
        memo[child.name] = child.text.strip
        memo
      end
    end
  end
end
