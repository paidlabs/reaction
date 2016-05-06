amodule Reaction
  class Type
    attr_accessor :action
    attr_accessor :options

    attr_accessor :result
    attr_accessor :error
    attr_accessor :successful

    def initialize(action, options = {})
      @action = action
      @options = options
      @successful = nil
    end

    def process(raw_value)
      convert(raw_value)
      raise "You forgot to call success or failure!!!" if @successful.nil?
      @successful
    end

    def convert(raw_value)
      raise NotImplementedError
    end

    def successful?
      @successful == true
    end

    def success(result)
      @successful = true
      @result = result
    end

    def failed?
      @successful == false
    end

    def failure(error)
      @successful = false
      @error = error
    end

    # This isn't perfect but works well enough.
    def self.to_type_symbol
      ret = self.to_s
      ret.gsub!(/([A-Z]+)([A-Z])/, '\1_\2')
      ret.gsub!(/([a-z])([A-Z])/, '\1_\2')
      ret.downcase!
      ret.gsub!(/_type$/, '')
      ret.to_sym
    end
  end
end
