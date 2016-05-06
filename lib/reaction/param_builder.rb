module Reaction
  class ParamBuilder
    attr_accessor :name
    attr_accessor :type_builder
    attr_accessor :validator_builders

    def initialize(name, type_builder = nil, validator_builders = [])
      @name = name
      @type_builder = type_builder
      @validator_builders = validator_builders
    end

    def build(action, raw_value, provided = true)
      type = type_builder.build(action)
      validators = validator_builders.map{ |vb| vb.build(action) }
      Param.new(action, type, validators, name, raw_value, provided)
    end

  end
end
