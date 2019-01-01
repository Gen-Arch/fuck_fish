require "net/http"
require "json"
require 'uri'


module Elasticapi
  class << self

    def get
      path = File.join("diary", "get", "5")
      http_request("get", path)
    end

    def mget
      data = {
        #body: {query: {match: {data: {query: "test4"}}}}
        #index: "fuck_fish",
        #body: {query: {match: {text: {query: 'hello', operator: "and", zero_terms_query: "all"}}}}
        body: {
          query: {match_all: {}},
          _source: ["account_number", "balance"]
        }
      }
      path = File.join("mget")
      http_request("get", path)
    end

    def search
      data = {
        body: {
          query: {match: {text: "f"}},
          aggregations: { tags:  { terms: { field: 'tags' } }}
        }
      }

      path = File.join("search")
      http_request("get", path, data)
    end

    def index
      data = {
        body: {title: "てすと〜〜2",　text: "あ〜あ", name: "gen"
        }
      }
      path =  File.join("diary", "index", "gen4")
      http_request("post", path, data)
    end

    def delete
      path =  File.join("diary", "delete", "1")
      http_request("post", path)
    end


    def http_request(method, path, json=nil)
      url  = URI.parse('http://localhost:9200/fuck_fish/elastic/')
      http = Net::HTTP.start(url.host, url.port)

      req = Net::HTTP.const_get(method.capitalize).new(File.join(url.path, path))
      req["Content-Type"] = "application/json"
      req.body = json.to_json if json
      puts req.body
      http.request(req).body
    end
  end
end

if __FILE__ == $0
  puts Elasticapi.search
end
