require "models/diary"
require 'sinatra/param'

class API < Base
  before do
    cross_origin #cros対応
    content_type :json
    # protected! #=> Basic認証
  end

  get '/serch' do
    params :tags, Array
    params :query, Hash

    Diary.in(params[:query])
  end

  run! if app_file == $0
end
