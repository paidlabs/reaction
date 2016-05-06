require 'redcarpet'

module Reaction
  autoload :Action, 'reaction/action'
  autoload :HasAttributes, 'reaction/has_attributes'
  autoload :Param, 'reaction/param'
  autoload :ParamBuilder, 'reaction/param_builder'
  autoload :Type, 'reaction/type'
  autoload :TypeBuilder, 'reaction/type_builder'
  autoload :Validator, 'reaction/validator'
  autoload :ValidatorBuilder, 'reaction/validator_builder'
  autoload :AttributeError, 'reaction/errors/attribute_error'
  autoload :ParamError, 'reaction/errors/param_error'
  autoload :RawType, 'reaction/types/raw_type'
end
