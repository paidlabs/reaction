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

    def each
      messages
    end

    def full_messages
      ret = []
      messages.each do |key, values|
        values.each do |value|
          ret << "#{key}: #{value}"
        end
      end
      ret
    end
  end
end
