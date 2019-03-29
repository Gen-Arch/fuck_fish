require_relative 'types/base_type'
require_relative 'types/diary'
require 'models/diary'

class QueryType < Types::BaseType
  description 'The query root of this schema'

  field :diary, [Types::DiaryType], null: true do
    description 'Response All Data'
    argument :limit, Integer, required: false
  end

  field :search, [Types::DiaryType], null: true do
    description 'search'
    argument :title, String, required: false
    argument :text, String, required: false
    argument :name, String, required: false
    argument :tags, [String], required: false
  end

  def diary(limit: nil)
    if limit
      Diary.order_by(updated_at: 'desc').limit(limit)
    else
      Diary.order_by(updated_at: 'desc')
    end
  end

  def search(**query)
    Diary.where(**query)
  end
end
