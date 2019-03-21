require_relative '../graphql/appschema'

class Graphql < Base
  post '/' do
    result = AppSchema.execute(
      params[:query],
      variables: params[:variables],
      context: { current_user: nil },
    )
    json result
  end
end
