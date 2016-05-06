module Reaction
  class AttributeError < StandardError
    attr_accessor :attribute
    attr_accessor :message

    def initialize(attribute, message = nil)
      @attribute = attribute
      @message = message || "Missing value for attribute: #{attribute}."
    end

  end
end
