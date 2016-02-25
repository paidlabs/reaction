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
        set_type(name, options.delete(:type))
        set_validators(name, options)
      end
    end

    def param(name)
      typed_params[name.to_sym] ||= begin
        type = self.class.types[name.to_sym]
        type ? type.convert(raw_param(name)) : raw_param(name)
      end
    end

    def params
      @params ||= {}
    end

    def typed_params
      @typed_params ||= {}
    end

    def set_param(name, value, meta = {})
      set_meta(name, meta)
      params[name.to_sym] = value
    end

    def set_params(params = {}, meta = {})
      params.each do |name, value|
        set_param(name, value, meta)
      end
    end

    def raw_param(name)
      params[name.to_sym]
    end

  end
end
