module Reaction
  module HasErrors
    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods
    end

    def errors
      @errors ||= Errors.new
    end

  end
end
