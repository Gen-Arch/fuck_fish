class APP < Base
  get "/" do
    send_file File.join(settings.public_folder, 'index.html')
  end

  run! if app_file == $0
end
