module Reaction
  class EachValidator
    attr_reader :options

    def initialize(options = {})
      @options = options
    end

    # If you need to validate a parameter outside of the basic
    # type then validators are your best bet. They are generally
    # very similar to Rails' EachValidator, but instead of the first
    # argument being a record it is an action. You provide a
    # validate_each method that takes in a action, attribute, and
    # value and then if the attribute isn't valid adds an error
    # to action.errors. You can also access the data provided
    # for the validator via the +options+ method.
    #
    # Example validate_each method for a RequiredValidator which
    # would be used like:
    #
    #  param :cat, required: true
    #  param :dog, required: false
    #
    #
    #  def validate_each(action, attribute, value)
    #    if options && value.nil?
    #      action.errors.add(attribute, 'is required.')
    #    end
    #  end
    #
    def validate_each(action, attribute, value)
      raise NotImplementedError.new('Subclasses must implement a validate_each(action, attribute, value) method')
    end

    # Cleanup is provided in case you need to create files that
    # require cleanup after the action has been performed. For
    # example, Paid creates Tempfiles with some types and uses
    # the cleanup phase to ensure these files get closed up
    # properly.
    #
    def cleanup
    end
  end
end
