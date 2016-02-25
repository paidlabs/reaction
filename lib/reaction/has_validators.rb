module Reaction
  module HasValidators
    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods
      def validators
        @validators ||= {}
      end

      def set_validator(name, validator, options = {})
        klass = class_for_validator(validator)
        validators[name.to_sym] = klass.new(options)
      end

      def set_validators(name, validators = {})
        validators.each do |validator, options|
          set_validator(name, validator, options)
        end
      end

      def class_for_validator(validator)
        return validator if validator.is_a?(Class)
        name = validator.to_s.split('_').map(&:capitalize).join
        const_get("#{name}Validator")
      rescue NameError
        raise ArgumentError.new("Unknown param validator: #{validator}")
      end
    end

  end
end
