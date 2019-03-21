require "helper/graphql/query"

class Graphql < Base
  post '/' do
    result = Query.execute(
      params[:query],
      variables: params[:variables],
      context: { current_user: nil },
    )
    json result
  end
end
