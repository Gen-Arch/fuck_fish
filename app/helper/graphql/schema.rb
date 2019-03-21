require "models/diary"
require_relative 'types'

class QueryType < GraphQL::Schema::Object
  description "The query root of this schema"

  field :diary, [Types::Diary], null: true do
    description "Response All Data"
  end

  field :search, [Types::Diary], null: true do
    description "Find a post by name"
    argument :name, String, required: true
  end

  def diary
    Diary.all
  end

  def search(name:)
    Diary.where(:name => name)
  end
end
