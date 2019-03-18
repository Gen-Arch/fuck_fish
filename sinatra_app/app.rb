require "sinatra/base"
require 'sinatra/cross_origin'
require "json"
require "slim"
require "rack/contrib"

require_relative "../lib/application_helper"


class FuckFish < Sinatra::Base
  register Sinatra::CrossOrigin #cros対応

  configure do
    use Rack::PostBodyContentTypeParser
    #cros対応
    enable :cross_origin
    set :allow_origin, :any
    set :allow_methods, [:get, :post, :options]
    set :allow_credentials, true
    set :max_age, "1728000"
    set :expose_headers, ['Content-Type']

    #web server
    set :server, :puma

    # default root
    set :root, File.expand_path("..", __dir__)
  end

  #cros対応 optionsメソッド
  options "*" do
    response.headers["Allow"] = "HEAD,GET,PUT,POST,DELETE,OPTIONS"
    response.headers["Access-Control-Allow-Headers"] = "X-Requested-With, X-HTTP-Method-Override, Content-Type, Cache-Control, Accept"
    status 200
  end

  get "/" do
    slim :index
  end

  run! if app_file == $0
end
