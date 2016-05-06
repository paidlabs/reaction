module Reaction
  module HasAttributes
    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods
      def attribute(name)
        attr_accessor name
        eval(getter_code(name))
        attributes << name
      end

      def attributes
        @attributes ||= []
      end

      def getter_code(name)
        <<-CODE
        def #{name}
          self.#{name}
        end
CODE
      end
    end

    def attributes
      ret = {}
      self.class.attributes.each do |name|
        ret[name] = send(name)
      end
      ret
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
        unless send(attribute)
          # This is a server side error - we didn't set a valid attribute
          # for some reason, and attributes are things the server sets.
          failure(AttributeError.new(attribute)) and return false
        end
      end
    end

  end
end
