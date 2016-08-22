module RemoteAttrAccessor
  # Override by lib/remote_attr_accessor/api.rb
  class Api
    def self.get_remote_attrs_with_indifferent_access(ids)
      get_remote_attrs(ids).with_indifferent_access
    end

    def self.get_remote_attrs(ids)
      {}
    end

    def self.upsert_remote_attr(params)
    end
  end
end
