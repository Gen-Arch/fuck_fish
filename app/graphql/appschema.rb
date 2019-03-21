require 'graphql'
require_relative 'mutation'
require_relative 'query'

class AppSchema < GraphQL::Schema
  query QueryType
  mutation MutationType
end
