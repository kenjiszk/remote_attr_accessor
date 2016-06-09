require 'spec_helper'

describe 'get remote attribute' do
  it 'add instance variable' do
    ruser = {id: 1, email: 'ruser@test.com', last_name: 'last_name', first_name: 'first_name'}
    response = {'users': {'1': ruser}}.to_json
    allow(RemoteAttrAccessor::Api).to receive(:get_remote_attrs).and_return(JSON.parse(response))

    user = User.new(1)
    expect(user.remote_email).to eq ruser[:email]
    expect(user.remote_last_name).to eq ruser[:last_name]
    expect(user.remote_first_name).to eq ruser[:first_name]
  end
end

class User
  attr_accessor :id
  include RemoteAttrAccessor::Attrs

  def initialize(id)
    @id = id
  end
end
