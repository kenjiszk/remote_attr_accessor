module RemoteAttrAccessor
  class Config
    def self.id_name
      # Override as you want
      @id_name ||= 'id'
    end

    def self.prefix
      # Override as you want
      @prefix ||= 'remote_'
    end

    def self.remote_json_key
      # Override as you want
      @remote_json_key ||= 'users'
    end

    def self.remote_attrs
      # Override as you want
      @remote_attrs ||= [:email, :last_name, :first_name]
    end

    def self.remote_attrs_with_prefix
      @remote_attrs_with_prefix = remote_attrs.map{|attr| "#{prefix}#{attr}"}
    end
  end
end
