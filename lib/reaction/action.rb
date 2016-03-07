module Reaction
  class Action
    include HasAttributes
    include HasErrors
    include HasParams

    # meta isn't used by default, but it is supported for use cases
    # where you need to attach metadata to parameters, such as
    # who or what set the attribute. For example, Paid currently
    # has a flow like:
    #
    #   action = Action.new(request.params, via: :request)
    #   action.set_params(account: api_key.account, via: :api_key)
    #
    # Which allows us to use a validator to define who can set
    # various attributes. Specifically, we limit certain attributes
    # from being set by the request so end users can't set params
    # that we don't expect them to set.
    #
    def initialize(params = {}, meta = {})
      set_params(params, meta)
    end

    def invoke
      validate!
      ret = perform
    ensure
      cleanup
    end

    def perform
      # Implement this for your action
    end

    def validate!
      errors.clear
      validate_attributes
      validate_params
      if errors.any?
        raise ArgumentError.new("Validations failed: #{errors.full_messages.join(',')}")
      end
    end

    def cleanup
      cleanup_types
      cleanup_validators
    end
  end
end
