require 'redcarpet'

module Reaction
  autoload :Action, 'reaction/action'
  autoload :Doc, 'reaction/doc'
  autoload :EachValidator, 'reaction/each_validator'
  autoload :Errors, 'reaction/errors'
  autoload :HasAttributes, 'reaction/has_attributes'
  autoload :HasDocs, 'reaction/has_docs'
  autoload :HasErrors, 'reaction/has_errors'
  autoload :HasMetas, 'reaction/has_metas'
  autoload :HasParams, 'reaction/has_params'
  autoload :HasTypes, 'reaction/has_types'
  autoload :HasValidators, 'reaction/has_validators'
  autoload :IsDocumented, 'reaction/is_documented'
  autoload :Markdown, 'reaction/markdown'
  autoload :RawType, 'reaction/types/raw_type'
  autoload :Type, 'reaction/type'
end
