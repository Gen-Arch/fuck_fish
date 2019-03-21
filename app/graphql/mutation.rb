require_relative 'types/base_type'
require_relative 'mutation/create_diary'

class MutationType < Types::BaseType
  field :createDiary, mutation: Mutations::CreateDiary
end
