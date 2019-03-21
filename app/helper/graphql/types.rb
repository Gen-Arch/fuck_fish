module Types
  class BaseObject < GraphQL::Schema::Object; end

  class Diary < BaseObject
    description "A list of items which may be completed"

    field :title, String, "blog title", null: false
    field :text, String, "diary", null: false
    field :name, String, "username", null: false
    field :tags, String, "type tags", null: false
  end
end
