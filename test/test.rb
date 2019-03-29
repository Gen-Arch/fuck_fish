ENV['RACK_ENV'] = 'development'
ENV['DATABASE_NAME'] = 'diary'
require_relative '../app/models/diary'

user = Diary.all.first
p user.created_at
