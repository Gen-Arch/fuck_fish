require_relative "app"
require_relative "sinatra_app/elastic"

map("/") { run FuckFish }
map("/elastic") { run ElasticAPI }
