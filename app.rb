require "sinatra/base"
require 'sinatra/cross_origin'
require "slim"

require_relative "lib/application_helper"


class FuckFish < Sinatra::Base
  register Sinatra::CrossOrigin

  set :server, :puma

  before do
    request.script_name = "/fuck_fish"
  end

  configure do
      enable :cross_origin
  end

  get "/" do
    slim :index
  end

  options "*" do
    response.headers["Allow"] = "GET, POST, OPTIONS"
    response.headers["Access-Control-Allow-Headers"] = "Authorization, Content-Type, Accept, X-User-Email, X-Auth-Token"
    response.headers["Access-Control-Allow-Origin"] = "*"
    200
  end


  run! if app_file == $0
end
