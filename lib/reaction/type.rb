module Reaction
  class Type
    attr_reader :name

    def initialize(name)
      @name = name.to_sym
    end

    # If you need to validate based on type you can. These
    # work identically to the validators, except type validations
    # are always called before other validators, and the +options+
    # hash isn't available. If you have a particularly good
    # use case for passing in options to a Type reach out; It
    # should be pretty easy to add in, we just haven't had a
    # need for it yet.
    #
    def validate_each(record, attribute, value)
    end

    # Convert is used to transform a value into whatever
    # format you expect it to be. For example, you might
    # have a convert method that casts a string into an
    # integer, or one that takes in various date formats
    # and converts them to a DateTime prior to the param
    # being used in the action.
    #
    def convert(value)
      value
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
