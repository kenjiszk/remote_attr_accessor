module RemoteAttrAccessor::Bulk
  extend RemoteAttrAccessor::Base

  def load_remote_attr(locals)
    id_name = config.id_name
    ids = Array.new
    if locals.class == Array || locals.is_a?(ActiveRecord::Relation)
      locals.each do |local|
        ids << local.send(id_name)
      end
    elsif locals.is_a?(ActiveRecord::Base)
      ids << locals.send(id_name)
    end

    remote_attrs_json = api.get_remote_attrs_with_indifferent_access(ids)
    return if remote_attrs_json == {}
    remote_attrs = remote_attrs_json[config.remote_json_key]

    ((locals.class == Array || locals.is_a?(ActiveRecord::Relation)) ? locals : [locals]).each do |local|
      next unless remote_attrs.dig(local.send(id_name).to_s)

      ignored_attrs = [id_name.to_s, 'created_at', 'updated_at']
      (remote_attrs[local.send(id_name).to_s].keys - ignored_attrs).each do |rattr|
        attr_with_prefix = "@#{config.prefix}#{rattr}"
        local.instance_variable_set(attr_with_prefix, remote_attrs[local.send(id_name).to_s][rattr.to_s])
      end
    end
  end

  module_function :load_remote_attr
end
