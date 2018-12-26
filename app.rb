require "sinatra"
require 'sinatra/reloader'
require "elasticsearch"
require "slim"
require "json"
require 'rack/contrib'

require_relative "lib/application_helper"

use Rack::PostBodyContentTypeParser
set :server, :puma

before do
  request.script_name = "/fuck_fish"
end

helpers do
  def client
    @client ||= Elasticsearch::Client.new url: "http://localhost:9200", log: true
  end

  def arg_factory(type, **hash)
    default = {index: "fuck_fish", type: type}
    default.merge(hash) if hash
  end
end

get "/" do
  slim :index
end

get "/info/:mode" do
  content_type :json

  mode = params[:mode]
  client.cat.to_json if mode == "index"
  client.info.to_json if mode == "status"
end


get "/elastic/:type/get/:id" do
  content_type :json

  type = params[:type]
  id   = params[:id]
  args = arg_factory(type, id: id)
  client.get(**args).to_json
end 

get "/elastic/mget" do
  content_type :json

  type = params[:type]

  args = if type
           arg_factory(type)
         else
           {index: "fuck_fish"}
         end
  client.mget(**args).to_json
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

  args = if defined? body
           p body
           arg_factory(type, id: id, body: body)
         else
           arg_factory(type, id: id)
         end

  client.send(mode, **args).to_json
end

get "/elastic/search" do
  index = params[:index]
  body  = params[:body]
  args = {index: index, body: body}

  client.search(**args).to_json
end
