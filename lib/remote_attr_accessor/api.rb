module RemoteAttrAccessor
  class Api
    def self.get_remote_attrs(ids)
=begin
************************************************
Please overwite by your api.
Return json format is;

{"users"=>
  {"1"=>
    {"id"=>1,
     "email"=>"aaa@example.com",
     "last_name"=>"yamada",i
     "first_name"=>"taro",
     "created_at"=>"2016-05-23T16:14:38.000Z",
     "updated_at"=>"2016-05-25T13:49:59.000Z"},
   "2"=>
    {"id"=>2,
     "email"=>"bbb@example.com",
     "last_name"=>suzuki,
     "first_name"=>shiro,
     "created_at"=>"2016-05-23T16:14:38.000Z",
     "updated_at"=>"2016-05-23T16:14:38.000Z"}}}
************************************************
=end
      {}
    end

    def self.upsert_remote_attr(params)
      # Please override your api
    end
  end
end
