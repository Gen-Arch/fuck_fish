require "graphql"
require_relative 'schema'

class Query < GraphQL::Schema
  query QueryType
end
