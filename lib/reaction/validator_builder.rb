module Reaction
  class ValidatorBuilder
    attr_accessor :validator
    attr_accessor :options

    def initialize(validator, options = {})
      @validator = class_for_validator!(validator)
      @options = options
    end

    def build(action)
      validator.new(action, options)
    end

    def class_for_validator(validator)
      return validator if validator.is_a?(Class)
      name = validator.to_s.split('_').map(&:capitalize).join
      Module.const_get("#{name}Validator")
    rescue NameError
      nil
    end

    def class_for_validator!(validator)
      class_for_validator(validator) or raise ArgumentError.new("Unknown validator: #{validator}")
    end

  end
end
