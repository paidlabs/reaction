module Reaction
  class Param
    attr_accessor :action
    attr_accessor :type
    attr_accessor :validators
    attr_accessor :name
    attr_accessor :raw_value

    attr_accessor :successful
    attr_accessor :result
    attr_accessor :error

    def initialize(action, type, validators, name, raw_value, provided = true)
      @action = action
      @type = type
      @validators = validators
      @name = name
      @raw_value = raw_value
      @provided = provided
    end

    def process
      if type.process(raw_value)
        validators.each do |validator|
          unless validator.process(type.result)
            failure(validator.error) and return false
          end
        end
      else
        failure(type.error) and return false
      end
      success(type.result) and return true
    end

    def success(result)
      @successful = true
      @result = result
    end

    def failure(error)
      @successful = false
      @error = ParamError.new(name, error)
    end

    def provided?
      !!@provided
    end

  end
end
