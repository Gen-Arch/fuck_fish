require_relative "sinatra_app/app"
require_relative "sinatra_app/elastic"

map("/fuck_fish") { run FuckFish }
map("/elastic") { run ElasticAPI }
