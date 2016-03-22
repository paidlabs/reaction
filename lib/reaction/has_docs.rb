module Reaction
  module HasDocs
    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods
      def doc(name, message, options = {})
        docs[name.to_sym] = Doc.new(message, options)
      end

      def docs
        @docs ||= {}
      end
    end

    def doc(name)
      self.class.docs[name.to_sym]
    end

  end
end
