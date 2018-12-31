require "sinatra/base"
require "slim"

require_relative "lib/application_helper"


class FuckFish < Sinatra::Base

  before do
    request.script_name = "/fuck_fish"
  end

  get "/" do
    slim :index
  end

  run! if app_file == $0
end
