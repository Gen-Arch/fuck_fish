require "rack/contrib"
require_relative "app"
require_relative "sinatra_app/elastic"


use Rack::PostBodyContentTypeParser
map("/") { run FuckFish }
map("/elastic") { run ElasticAPI }
