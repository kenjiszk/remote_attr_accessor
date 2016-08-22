module RemoteAttrAccessor::Attrs
  extend RemoteAttrAccessor::Base

  Dir.glob("#{Dir.pwd}/lib/remote_attr_accessor/*.rb").each { |r| require r}

  config.remote_attrs.each do |attr|
    attr_with_prefix = config.prefix + attr.to_s
    define_method(attr_with_prefix) do
      config = RemoteAttrAccessor::Config
      remote_id = eval(config.id_name).to_s
      eval("@#{attr_with_prefix}") ||
        instance_variable_set(
          "@#{attr_with_prefix}", 
          RemoteAttrAccessor::Api.get_remote_attrs_with_indifferent_access([remote_id])[config.remote_json_key][remote_id][attr.to_s]
            rescue nil
        )
    end

    define_method("#{attr_with_prefix}=") do |val|
      config = RemoteAttrAccessor::Config
      params = Hash.new
      params[config.id_name] = eval(config.id_name).to_s
      params[attr.to_s] = val
      RemoteAttrAccessor::Api.upsert_remote_attr(params)
      instance_variable_set("@#{attr_with_prefix}", nil)
    end
  end
end
