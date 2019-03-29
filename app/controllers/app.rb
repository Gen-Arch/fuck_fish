class APP < Base
  get "/" do
    redirect 'http://localhost:8081'
  end

  run! if app_file == $0
end
