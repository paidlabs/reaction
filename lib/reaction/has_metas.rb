module Reaction
  module HasMetas
    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods
    end

    def meta(name)
      metas[name.to_sym]
    end

    def metas
      @metas ||= {}
    end

    def set_meta(name, meta)
      metas[name.to_sym] = meta
    end

  end
end
