module RemoteAttrAccessor::Bulk
  extend RemoteAttrAccessor::Base

  def load_remote_attr(locals, id_name)
    ids = Array.new
    if locals.is_a?(ActiveRecord::Relation)
      locals.each do |local|
        ids << local[id_name]
      end
    elsif locals.is_a?(ActiveRecord::Base)
      ids << locals[id_name]
    end

    remote_attrs_json = api.get_remote_attrs(ids)
    return if remote_attrs_json == {}
    remote_attrs = remote_attrs_json[config.remote_json_key]

    (locals.is_a?(ActiveRecord::Relation || Array) ? locals : [locals]).each do |local|
      ignored_attrs = [id_name.to_s, 'created_at', 'updated_at']
      (remote_attrs[local[id_name].to_s].keys - ignored_attrs).each do |rattr|
        attr_with_prefix = "@#{config.prefix}#{rattr}"
        local.instance_variable_set(attr_with_prefix, remote_attrs[local[id_name].to_s][rattr.to_s])
      end
    end
  end

  module_function :load_remote_attr
end
