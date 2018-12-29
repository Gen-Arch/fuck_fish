require "sinatra"
require 'sinatra/reloader' if ENV['RACK_ENV'] == "development"
require "elasticsearch"
require "slim"
require "json"
require 'jbuilder'
require 'rack/contrib'

require_relative "lib/application_helper"

use Rack::PostBodyContentTypeParser
set :server, :puma


before do
  request.script_name = "/fuck_fish"
end

configure do
  @client ||= Elasticsearch::Client.new url: "http://localhost:9200", log: true
  @index  = "fuck_fish"
end

helpers do
  def arg_factory(type, **hash)
    default = {index: @index, type: type}
    default.merge(hash) if hash
  end

  def jbuilder(query)
    raise unless query.is_a?(Hash)
    raise unless query.size == 1

    key, val = *query
    query = Jbuilder.encode do |json| ; json.query do ; json.match do
      json.send(key) do
        json.query(val)
        json.operator 'and'
      end
    end; end; end
  end
end

get "/" do
  slim :index
end


get "/elastic/:type/get/:id" do
  content_type :json

  type = params[:type]
  id   = params[:id]
  args = arg_factory(type, id: id)
  client.get(**args).to_json
end 

get "/elastic/search" do
  content_type :json
  args  = {index: @index}

  if params.key?(:query)
    query = params[:query] 
    query = jbuilder(query) if query.is_a?(Hash)
    args.merge!(query: query)
  end
  client.search(**args).to_json
end

post "/elastic/:type/:mode" do
  content_type :json
  type = params[:type]
  mode = params[:mode]
  id   = params[:id]   if params.key?(:id)
  body = params[:body] if params.key?(:body)

  begin
    raise unless  ["index", "delete"].include?(mode)

    args = if defined? body
             p body
             arg_factory(type, body: body)
           elsif defined? id
             arg_factory(type, id: id)
           else
             raise
           end
    client.send(mode, **args).to_json

  rescue => e
    err = {err: e}
    status 400
    err.to_json
  end
end
