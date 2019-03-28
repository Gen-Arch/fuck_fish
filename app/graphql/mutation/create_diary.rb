require_relative 'base_mutation'
require 'models/diary'

module Mutations
  class CreateDiary < BaseMutation
    description 'Creates a diary'

    argument :title, String, required: true
    argument :text, String, required: false
    argument :name, String, required: true
    argument :tags, [String], required: false

    field :success, Boolean, null: false
    field :errors, [String], null: false

    def resolve(title:, text:, name:, tags:)
      diary = Diary.new(
        title: title,
        text: text,
        name: name,
        tags: tags
      )

      if diary.save
        {
          success: true,
          errors: []
        }
      else
        {
          success: false,
          errors: diary.errors.full_messages
        }
      end
    end
  end
end
