module Reaction
  class TypeBuilder
    attr_accessor :type
    attr_accessor :options

    def initialize(type = RawType, options = {})
      @type = class_for_type!(type)
      @options = options
    end

    def build(action)
      type.new(action, options)
    end

    def class_for_type(type)
      return type if type.is_a?(Class)
      name = type.to_s.split('_').map(&:capitalize).join
      Module.const_get("#{name}Type")
    rescue NameError
      nil
    end

    def class_for_type!(type)
      class_for_type(type) or raise ArgumentError.new("Unknown type: #{type}")
    end

  end
end
