require "sinatra/base"
require "slim"

require_relative "lib/application_helper"


class FuckFish < Sinatra::Base
  set :server, :puma
  set :public_folder, File.expand_path("../public", __dir__)

  before do
    request.script_name = "/fuck_fish"
  end

  get "/" do
    slim :index
  end

  run! if app_file == $0
end
