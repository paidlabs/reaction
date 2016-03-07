module Reaction
  module HasValidators
    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods
      def all_validators
        @all_validators ||= {}
      end

      def validators(name)
        all_validators[name.to_sym] ||= []
        all_validators[name.to_sym]
      end

      def add_validator(name, validator, options = {})
        klass = class_for_validator(validator)
        validators(name) << klass.new(options)
      end

      def set_validators(name, new_validators = {})
        validators(name).clear
        new_validators.each do |validator, options|
          add_validator(name, validator, options)
        end
      end

      def class_for_validator(validator)
        return validator if validator.is_a?(Class)
        name = validator.to_s.split('_').map(&:capitalize).join
        const_get("#{name}Validator")
      rescue NameError
        raise ArgumentError.new("Unknown param validator: #{validator}")
      end

      def cleanup_validators
        all_validators.each do |name, validators|
          validators.each do |validator|
            validator.cleanup
          end
        end
      end
    end

    def cleanup_validators
      self.class.cleanup_validators
    end

  end
end
