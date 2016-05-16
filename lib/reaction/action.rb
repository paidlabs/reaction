module Reaction
  class Action
    include HasAttributes

    attr_accessor :successful
    attr_accessor :result
    attr_accessor :error

    def initialize(param_values = {}, attribute_values = {})
      set_params(param_values)
      set_attributes(attribute_values)
    end

    def process
      return false unless validate_attributes
      _params.each do |name, param|
        unless param.process
          failure(param.error)
          return false
        end
      end
      perform
      return !!@successful
    end

    def success(result)
      @result = result
      @successful = true
    end

    def failure(error)
      @error = error
      @successful = false
    end

    def failed?
      @successful == false
    end

    # This is how you retrieve a param. Pass in a mode of :raw in
    # order to get the raw param if you happen to need that, but
    # in general you shouldn't.
    #
    def param(name, mode = :converted)
      if mode == :raw
        _param(name).raw_value
      else
        _param(name).result
      end
    end

    def params(mode = :converted)
      ret = {}
      _params.each do |name, param|
        if mode == :raw
          ret[name] = param.raw_value if param.provided?
        else
          ret[name] = param.result if param.provided?
        end
      end
      ret
    end

    def set_params(param_values = {})
      provided_keys = param_values.keys.map(&:to_sym)

      self.class.param_builders.each do |name, pb|
        provided = provided_keys.include?(name)
        _params[name] = pb.build(self, param_values[name], provided)
      end
    end

    def param_provided?(name)
      _param(name).provided?
    end

    def self.process(param_values = {}, attribute_values = {})
      action = new(param_values, attribute_values)
      if action.process
        return [action.result, nil]
      else
        return [nil, action.error]
      end
    end

    def self.param_builders
      @param_builders ||= {}
    end

    def self.param_builder(name)
      name.to_sym
      param_builders[name] ||= ParamBuilder.new(name)
    end

    def self.param(name, type = RawType, options = {})
      param_builder(name).type_builder = TypeBuilder.new(type, options)
    end

    def self.validates(name, validators = {})
      validators.each do |validator, options|
        param_builder(name).validator_builders << ValidatorBuilder.new(validator, options)
      end
    end

  private

    def _param(name)
      name = name.to_sym
      unless self.class.param_builders[name]
        raise ArgumentError, "Invalid param: #{name}"
      end
      _params[name]
    end

    def _params
      @params ||= {}
    end

  end
end
