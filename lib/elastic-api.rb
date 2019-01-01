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

      res = if json.nil?
              Elasticapi.send(opts[:mode])
            else
              Elasticapi.send(opts[:mode], JSON.parse(json))
            end
      #pp res
      pp JSON.parse(res)
    end

    def get
      path = File.join("diary", "get", "5")
      http_request("get", path)
    end

    def search(data=nil)
      path = File.join("search")

      if data.nil?
        http_request("get", path)
      else
        http_request("get", path, data)
      end
    end

    def index(data)
      path =  File.join("index", "diary")
      http_request("post", path, data)
    end

    def delete(data)
      path =  File.join("delete", "diary")
      http_request("post", path, data)
    end


    def http_request(method, path, json=nil)
      url  = URI.parse('http://localhost:9200/fuck_fish/elastic/')
      http = Net::HTTP.start(url.host, url.port)

      req = Net::HTTP.const_get(method.capitalize).new(File.join(url.path, path))
      req["Content-Type"] = "application/json"
      
      puts "[request url]"
      puts url + path
      puts "=" * 50
      unless json.nil?
        puts "[request json]"
        req.body = json.to_json
        pp req.body
        puts "=" * 50
      end
      http.request(req).body
    end
  end
end

Elasticapi.cli if __FILE__ == $0
