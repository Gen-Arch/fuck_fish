ENV['RACK_ENV'] = 'development'

require_relative '../app/models/diary'


user = Diary.all.first
p user.created_at
