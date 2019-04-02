require 'sinatra/json'
require_relative '../graphql/appschema'

class Graphql < Base
  before do
    cross_origin #cros対応
    content_type :json
    # protected! #=> Basic認証
  end

  post '/' do
    puts params[:query]
    result = AppSchema.execute(
      params[:query],
      variables: params[:variables],
      context: { current_user: nil },
    )
    json result
  end
end
