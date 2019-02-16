require_relative "sinatra_app/app"
require_relative "sinatra_app/elastic"

root_path = ENV["RELATIVE_URL_ROOT"] || "/"

map(root_path) { run FuckFish }
map(root_path + "/elastic") { run ElasticAPI }
