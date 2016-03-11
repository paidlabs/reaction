module Reaction
  class Errors

    attr_accessor :messages

    def initialize
      @messages = {}
    end

    def clear
      messages.clear
    end

    def include?(key)
      !messages[key].nil?
    end

    def get(key)
      messages[key]
    end

    def add(key, message)
      messages[key] ||= []
      messages[key] << message
    end

    def any?
      messages.any?
    end

    def first
      messages.first
    end

    def each
      messages
    end

    def full_messages
      ret = []
      messages.each do |key, values|
        ret |= full_messages_for(key, values)
      end
      ret
    end

    def full_messages_for(key, values = nil)
      ret = []
      values ||= messages[key]
      values.each do |value|
        ret << "Invalid value for param: #{key}. #{value.capitalize}"
      end
      ret
    end
  end
end
