module Reaction
  module HasAttributes
    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods
      def attribute(name)
        attr_accessor name
        attributes << name
      end

      def attributes
        @attributes ||= []
      end
    end

    def set_attributes(attributes = {})
      attributes.each do |key, value|
        if self.class.attributes.include?(key)
          send("#{key}=", value)
        end
      end
    end

    def validate_attributes
      self.class.attributes.each do |attribute|
        errors.add(attribute, 'is not set.') unless send(attribute)
      end
    end

  end
end
