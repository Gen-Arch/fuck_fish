require 'mongoid'

Mongoid.load!(File.join(__dir__, 'mongoid.yml'))

class Diary
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title,  type: String
  field :text,  type: String
  field :name,  type: String
  field :tags,  type: Array
end
