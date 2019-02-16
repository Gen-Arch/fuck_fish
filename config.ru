require "rack/contrib"
require_relative "sinatra_/app"
require_relative "sinatra_app/elastic"


use Rack::PostBodyContentTypeParser
map("/fuck_fish") { run FuckFish }
map("/elastic") { run ElasticAPI }
