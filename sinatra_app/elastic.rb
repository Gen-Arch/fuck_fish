require "sinatra/base"
require "elasticsearch"
require "json"
require 'rack/contrib'

class ElasticAPI < Sinatra::Base

  use Rack::PostBodyContentTypeParser

  before do
    @index  = "fuck_fish"
  end

  helpers do
    def client
      @client ||= Elasticsearch::Client.new url: "http://localhost:9200", log: true
    end

    def arg_factory(type, **hash)
      default = {index: @index, type: type}
      default.merge(hash) if hash
    end

    def jbuilder(query)
      raise unless query.is_a?(Hash)
      raise unless query.size == 1

      key, val = query.first
      {query: {match: {key.to_sym => {query: val, operator: "and"}}}}
    end
  end

  get "/elastic/get/:type/:id" do
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
      if query.is_a?(Hash)
        query = jbuilder(query) 
        p query
        args.merge!(body: query)
      else
        args.merge!(q: query)
      end
    end

    client.search(**args).to_json
  end

  post "/elastic/:mode/:type" do
    content_type :json
    type = params[:type]
    mode = params[:mode]
    id   = params[:id]   if params.key?(:id)
    body = params[:body] if params.key?(:body)

    begin
      raise unless  ["index", "delete"].include?(mode)

      args = case mode
             when "index"  then arg_factory(type, body: body)
             when "delete" then arg_factory(type, id: id)
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
end
