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

    def validate_attributes
      attributes.each do |attribute|
        errors.add(attribute, 'is not set.') unless send(attribute)
      end
    end

  end
end
