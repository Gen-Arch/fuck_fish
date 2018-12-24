require "sinatra"
require 'sinatra/reloader'
require "slim"

set :server, :puma

before do
  request.script_name = "/fuck_fish"
end

get "/" do
  slim :index
end
