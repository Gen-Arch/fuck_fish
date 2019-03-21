require_relative 'types/base_type'
require_relative 'types/diary'
require 'models/diary'

class QueryType < Types::BaseType
  description 'The query root of this schema'

  field :diary, [Types::DiaryType], null: true do
    description 'Response All Data'
  end

  field :search, [Types::DiaryType], null: true do
    description 'search'
    argument :title, String, required: false
    argument :text, String, required: false
    argument :name, String, required: false
    argument :tags, [String], required: false
  end

  def diary
    Diary.all
  end

  def search(**query)
    Diary.where(**query)
  end
end
