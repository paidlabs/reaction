module Reaction
  module IsDocumented
    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods
      def doc(message = nil, options = {})
        if message
          @doc = Doc.new(message, options)
        else
          @doc
        end
      end
    end

  end
end
