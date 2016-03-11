# This class serves no real purpose in this gem, but is here so that
# developers can use it to create more dynamic documentation by
# documenting attributes used for actions directly in the actions,
# and then access these when generating their actual documenation.
#
module Reaction
  class Doc
    attr_reader :message, :options

    def initialize(message, options = {})
      @message = message
      @options = options
    end

  end
end
