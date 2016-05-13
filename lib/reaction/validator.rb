module Reaction
  class Validator
    attr_accessor :action
    attr_accessor :options

    attr_accessor :error
    attr_accessor :successful


    def initialize(action, options = {})
      @action = action
      @options = options
    end

    def process(value)
      # Assume successful unless a failure for validators
      @successful = true

      validate(value)
      !!@successful
    end

    def failure(error)
      @successful = false
      @error = error
    end

    def failed?
      @successful == false
    end

  end
end
