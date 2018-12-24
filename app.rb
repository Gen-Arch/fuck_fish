require "sinatra"
require 'sinatra/reloader'
require "elasticsearch"
require "slim"
require "json"
require 'rack/contrib'

set :server, :puma

before do
  request.script_name = "/fuck_fish"
end

helpers do
  def client
    @client ||= Elasticsearch::Client.new url: "http://localhost:9200", log: true
  end
  
  def query(type, **hash)
    q = {index: "fuck_fish", type: type}
    q.merge(hash) if hash
  end
end

get "/" do
  slim :index
end

get "/info" do
  content_type :json
  client.info.to_json
end

get "/elastic/:type/get/:id" do
  content_type :json
  type = params.delete(:type)
  id = params.delete(:id)
  q = query(type, id: id)
  client.get(**q).to_json
end 

post "/elastic/:type/:mode/:id" do
  content_type :json
  type = params[:type]
  id   = params[:id]
  mode = params[:mode]
  body = params[:body] if params.key?(:body)

  begin
    raise unless  ["index", "delete"].include?(mode)
  rescue => e
    err = {err: e}
    status 400
    err.to_json
  end

  if defined? body
    q = query(type, id: id, body: body)
  else
    q = query(type, id: id)
  end
  client.send(mode, **q).to_json
end
