class API < Base
  before do
    cross_origin #cros対応
    content_type :json
  end

  run! if app_file == $0
end
