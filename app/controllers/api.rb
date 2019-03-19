require 'models/diary'
require 'sinatra/json'
require 'sinatra/param'
require 'json'
require 'helper/hashsymbols'

class API < Base
  helpers Sinatra::Param

  before do
    cross_origin #cros対応
    content_type :json
    # protected! #=> Basic認証
  end

  helpers do
    def response_json!(result)
      # success  = (result.delete(:ok?) || false)
      success = false
      response = {
        ok?: success,
        request: params,
        result: result
      }

      json response
    end
  end

  get '/' do
    limit = params[:limit] || 30
    res = Diary.order_by(created_at: 'desc').limit(limit).to_a

    response_json! res
  end

  post '/insert' do
    param :query, Hash, required: true

    query = params['query'].to_sym_keys

    res = Diary.create(query)
    response_json! res
  end

  run! if app_file == $0
end
