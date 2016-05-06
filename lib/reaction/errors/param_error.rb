module Reaction
  class ParamError < StandardError
    attr_accessor :param
    attr_accessor :message

    def initialize(param, message = nil)
      @param = param
      @message = message || "Invalid value for param: #{param}."
    end

  end
end
