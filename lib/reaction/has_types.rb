module Reaction
  module HasTypes
    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods
      def types
        @types ||= {}
      end

      def set_type(name, type)
        type ||= Type
        klass = class_for_type(type)
        types[name.to_sym] = klass.new(name)
      end

      def class_for_type(type)
        return type if type.is_a?(Class)
        name = type.to_s.split('_').map(&:capitalize).join
        const_get("#{name}Type")
      rescue NameError
        nil
      end
    end

  end
end
