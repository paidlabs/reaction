# This is the default type for any param. It doesn't do any
# validations and simply returns the value as provided.
#
module Reaction
  class RawType < Type
    def validate_each(action, attribute, value)
    end

    def convert(action, attribute, value)
      value
    end

    def cleanup
    end
  end
end
