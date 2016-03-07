module Reaction
  module HasTypes
    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods
      def type(name)
        types[name.to_sym]
      end

      def types
        @types ||= {}
      end

      def set_type(name, type)
        type ||= Type
        klass = class_for_type!(type)
        types[name.to_sym] = klass.new(name)
      end

      def class_for_type(type)
        return type if type.is_a?(Class)
        name = type.to_s.split('_').map(&:capitalize).join
        const_get("#{name}Type")
      rescue NameError
        nil
      end

      def class_for_type!(type)
        class_for_type(type) or raise ArgumentError.new("Unknown type: #{type}")
      end

      def cleanup_types
        types.each do |name, type|
          type.cleanup
        end
      end
    end

    def cleanup_types
      self.class.cleanup_types
    end

  end
end
