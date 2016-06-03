module RemoteAttrAccessor
  # Override by lib/remote_attr_accessor/config.rb
  class Config
    def self.id_name
      'id'
    end

    def self.prefix
      'remote_'
    end

    def self.remote_json_key
      'users'
    end

    def self.remote_attrs
      [:email, :last_name, :first_name]
    end

    def self.remote_attrs_with_prefix
      @remote_attrs_with_prefix = remote_attrs.map{|attr| "#{prefix}#{attr}"}
    end
  end
end
