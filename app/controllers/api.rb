require "models/diary"
require 'sinatra/param'
require 'sinatra/json'

class API < Base
  before do
    cross_origin #cros対応
    content_type :json
    # protected! #=> Basic認証
  end

  get '/' do
    # params :tags, Array
    # params :query, Hash

    j = {test: Diary.all}
    json j
  end

  get '/test' do
    Diary.create(title: "test1",
                text: "tesgdshfashkdjf",
                name: "gen",
                tags: ["test", "test2"]
                )
    j = {test: Diary.all}
    json j
  end

  run! if app_file == $0
end
