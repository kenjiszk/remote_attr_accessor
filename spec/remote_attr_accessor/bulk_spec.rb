require 'spec_helper'

describe 'bulk get remote attribute' do
  it 'set remote params to ActiveRecord::Relation' do
    ruser1 = {id: 1, email: 'ruser1@test.com', last_name: 'last_name1', first_name: 'first_name1'}
    ruser2 = {id: 2, email: 'ruser2@test.com', last_name: 'last_name2', first_name: 'first_name2'}
    response = {'users': {'1': ruser1, '2': ruser2}}.to_json
    allow(RemoteAttrAccessor::Api).to receive(:get_remote_attrs).and_return(JSON.parse(response))

    users = [User.new(1), User.new(2)]
    RemoteAttrAccessor::Bulk.load_remote_attr(users)

    # TODO it is not strict TEST...
    expect(users[0].remote_email).to eq ruser1[:email]
    expect(users[0].remote_last_name).to eq ruser1[:last_name]
    expect(users[0].remote_first_name).to eq ruser1[:first_name]
    expect(users[1].remote_email).to eq ruser2[:email]
    expect(users[1].remote_last_name).to eq ruser2[:last_name]
    expect(users[1].remote_first_name).to eq ruser2[:first_name]
  end
end

class User
  attr_accessor :id
  include RemoteAttrAccessor::Attrs

  def initialize(id)
    @id = id
  end
end
