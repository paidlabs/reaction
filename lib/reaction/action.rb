module Reaction
  class Action
    include HasErrors
    include HasParams
    include HasAttributes

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
      validate_attributes!
      params.each do |name, value|
        unless self.class.class_for_type(name)
          errors.add(name, 'is not a valid parameter.')
        end
      end
      self.class.types.each do |name, type|
        type.validate_each(self, name, raw_param(name))
      end
      self.class.validators.each do |name, validator|
        validator.validate_each(self, name, raw_param(name))
      end
      if errors.any?
        raise ArgumentError.new("Validations failed: #{errors.full_messages.join(',')}")
      end
    end

    def cleanup
      self.class.types.each do |name, type|
        type.cleanup
      end
      self.class.validators.each do |name, validator|
        validator.cleanup
      end
    end
  end
end
