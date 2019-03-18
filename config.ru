$: << File.join(__dir__, "app")

require "controllers/base"
require "controllers/app"
require "controllers/api"

url = ENV['RELATIVE_URL_ROOT'] || '/'

map(url) { run APP }
map(File.join(url, "/api")) { run API }
