# This is the default type for any param. It doesn't do any
# validations and simply returns the value as provided.
#
module Reaction
  class RawType < Type

    def convert(raw_value)
      success(raw_value)
    end

  end
end
