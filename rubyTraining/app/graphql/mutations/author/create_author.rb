module Mutations
  module Author
    class CreateAuthor < BaseMutation
      argument :name, String, required: true
      argument :email, String, required: true

      type Types::AuthorType

      def resolve(name:, email:)
        ::Author.create!(name: name, email: email)
      rescue ActiveRecord::RecordInvalid => e
        GraphQL::ExecutionError.new(e.message)
      end
    end
  end
end
