require "elasticsearch"
require "json"
require 'rack/contrib'

class ElasticAPI < FuckFish

  use Rack::PostBodyContentTypeParser

  before do
    @index  = "fuck_fish"
  end

  helpers do
    def client
      url =

       settings.development? ? ENV["ELASTICSEARCH_URL"] : "http://localhost:9200"
      @client ||= Elasticsearch::Client.new url: url, log: true
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

    def err_json!(req, err=nil)
      req.merge({"RESULT" => err}).to_json
    end
  end

  get "/get/:type/:id" do
    content_type :json

    type = params[:type]
    id   = params[:id]
    args = arg_factory(type, id: id)
    client.get(**args).to_json

  rescue => err
    status 400
    err_json!(request.env, err)
  end

  get "/search" do
    content_type :json
    args  = {index: @index}
    query = params[:query]

    case query
    when String
      args.merge!(q: query)
    when Hash
      query = jbuilder(query) 
      args.merge!(body: query)
    end

    client.search(**args).to_json

  rescue => err
    status 400
    err_json!(request.env, err)
  end

  ["index", "delete"].each do |mode|
    post "/#{mode}/:type" do
      content_type :json
      type = params[:type]
      id   = params[:id]   if params.key?(:id)
      body = params[:body] if params.key?(:body)

      args = case mode
             when "index"  then arg_factory(type, body: body)
             when "delete" then arg_factory(type, id: id)
             else
               raise "no mode!!"
             end
      client.send(mode, **args).to_json

    rescue => err
      status 400
      err_json!(request.env, err)
    end
  end
end
