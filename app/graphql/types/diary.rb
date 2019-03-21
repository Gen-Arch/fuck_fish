require_relative 'base_type'
module Types
  class DiaryType < BaseType
    field :title, String, null: false
    field :text, String, null: true
    field :name, String, null: false
    field :tags, [String], null: true
  end
end
