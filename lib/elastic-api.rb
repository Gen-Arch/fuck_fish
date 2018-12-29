require "net/http"
require "json"
require 'uri'
require 'optparse'


module Elasticapi
  class << self

    def cli(argv = ARGV)
      op   = OptionParser.new
      opts = Hash.new
      op.on('-m', '--mode [VALUE]', "set api mode") {|v| opts[:mode] = v }
      json, _ = op.parse(argv)

      Elasticapi.send(opts[:mode], JSON.parse(json))
    end

    def get
      path = File.join("diary", "get", "5")
      http_request("get", path)
    end

    def search(data)
      path = File.join("search")
      http_request("get", path, data)
    end

    def index(data)
      path =  File.join("diary", "index")
      http_request("post", path, data)
    end

    def delete
      path =  File.join("diary", "delete", "1")
      http_request("post", path)
    end


    def http_request(method, path, json=nil)
      url  = URI.parse('http://localhost/fuck_fish/elastic/')
      http = Net::HTTP.start(url.host, url.port)

      req = Net::HTTP.const_get(method.capitalize).new(File.join(url.path, path))
      req["Content-Type"] = "application/json"
      req.body = json.to_json if json
      puts req.body
      http.request(req).body
    end
  end
end

Elasticapi.cli if __FILE__ == $0
