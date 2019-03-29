require 'mongoid'
Mongoid.load!(File.expand_path('../../config/mongoid.yml', __dir__))

class Diary
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title,  type: String
  field :text,  type: String
  field :name,  type: String
  field :tags,  type: Array
end
