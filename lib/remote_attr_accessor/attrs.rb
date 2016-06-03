module RemoteAttrAccessor::Attrs
  extend RemoteAttrAccessor::Base

  # Tricky
  def method_missing(name, *args)
    Rails.logger.info(name)
    # skip if name is not included in remote_attrs_with_prefix
    super unless config.remote_attrs_with_prefix.grep(/#{name}/)

    Rails.logger.info('not skipped! define method')
    # attr methods are defined after configs are overwritten
    config.remote_attrs.each do |attr|
      attr_with_prefix = config.prefix + attr.to_s
      Rails.logger.info(attr_with_prefix)
      define_method(attr_with_prefix) do
        config = RemoteAttrAccessor::Config
        remote_id = eval(config.id_name).to_s
        eval("@#{attr_with_prefix}") ||
          instance_variable_set(
            "@#{attr_with_prefix}", 
            RemoteAttrAccessor::Api.get_remote_attrs([remote_id])[config.remote_json_key][remote_id][attr.to_s]
          )
      end

      Rails.logger.info("#{attr_with_prefix}=")
      define_method("#{attr_with_prefix}=") do |val|
        config = RemoteAttrAccessor::Config
        params = Hash.new
        params[config.id_name] = eval(config.id_name).to_s
        params[attr.to_s] = val
        RemoteAttrAccessor::Api.upsert_remote_attr(params)
        instance_variable_set("@#{attr_with_prefix}", nil)
      end
    end

    send(name, *args)
  end
end
