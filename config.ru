$: << File.join(__dir__, 'app')

require 'controllers/base'
require 'controllers/app'
require 'controllers/api'
require 'controllers/graphql'

url = ENV['RELATIVE_URL_ROOT'] || '/'

map(url) { run APP }
map(File.join(url, '/api')) { run API }
map(File.join(url, '/graphql')) { run Graphql }
