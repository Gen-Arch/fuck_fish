require "elasticsearch"

class ElasticAPI < FuckFish
  before do
    cross_origin #cros対応
    content_type :json
    @index  = "fuck_fish"
  end

  helpers do
    def client
      #elasticsearch-ruby gem, get object
      #https://github.com/elastic/elasticsearch-ruby
      
      url = settings.development? ? ENV["ELASTICSEARCH_URL"] : "http://localhost:9200"
      @client ||= Elasticsearch::Client.new url: url, log: true
    end

    def arg_factory(type, **hash)
      #elastic gem 変数調整用
      default = {index: @index, type: type}
      default.merge(hash) if hash
    end

    def jbuilder(query)
      #elastic gem method => search
      #json変数 調整用
      raise unless query.is_a?(Hash)
      raise unless query.size == 1

      key, val = query.first
      {query: {match: {key.to_sym => {query: val, operator: "and"}}}}
    end

    def err_json!(req, err=nil)
      #err status conversion => json
      req.merge({"result" => err}).to_json
    end
  end

  get "/get/:type/:id" do

    type = params[:type]
    id   = params[:id]
    args = arg_factory(type, id: id)
    client.get(**args).to_json

  end

  get "/search" do
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

  end

  ["index", "delete"].each do |mode|
    post "/#{mode}/:type" do
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
    end
  end

  error do
    status 400
    err_json!(request.env, env['sinatra.error'].name)
  end
end
