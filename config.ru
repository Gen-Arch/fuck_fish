require_relative "app"

use Rack::PostBodyContentTypeParser

run Sinatra::Application
