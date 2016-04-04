module Reaction
  module HasParams
    def self.included(base)
      base.include HasDocs
      base.include HasMetas
      base.include HasTypes
      base.include HasValidators
      base.extend ClassMethods
    end

    module ClassMethods
      def param(name, options = {})
        set_type(name, options.delete(:type) || RawType)
        set_validators(name, options)
      end

      def param_settable?(name)
        !type(name).nil?
      end
    end

    def param_provided?(name)
      raw_params.has_key?(name.to_sym)
    end

    def param(name)
      typed_params[name.to_sym] ||= begin
        type = self.class.types[name.to_sym]
        type.convert(raw_param(name))
      end
    end

    def params
      ret = {}
      raw_params.keys.each do |name|
        ret[name.to_sym] = param(name)
      end
      ret
    end

    def typed_params
      @typed_params ||= {}
    end

    def rm_param(name)
      ret = param(name)
      rm_meta(name)
      raw_params.delete(name.to_sym)
      ret
    end

    def set_param(name, value, meta = {})
      return unless self.class.param_settable?(name)
      set_meta(name, meta)
      raw_params[name.to_sym] = value
    end

    def set_params(params = {}, meta = {})
      params.each do |name, value|
        set_param(name, value, meta)
      end
    end

    def raw_param(name)
      raw_params[name.to_sym]
    end

    def raw_params
      @raw_params ||= {}
    end

    def validate_params
      raw_params.each do |name, value|
        self.class.type(name).validate_each(self, name, value)
        converted = param(name)
        self.class.validators(name).each do |validator|
          validator.validate_each(self, name, converted)
        end
      end
    end

  end
end
