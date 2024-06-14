module Mutations
  module Author
    class UpdateAuthor < BaseMutation
      argument :id, ID, required: true
      argument :name, String, required: false
      argument :email, String, required: false

      type Types::AuthorType

      # Update author resolver - return Author or error
      def resolve(id:, name: nil, email: nil)
        author = ::Author.find(id)
        author.update!(name: name, email: email)
        author
      rescue ActiveRecord::RecordNotFound => e
        GraphQL::ExecutionError.new("Author not found")
      rescue ActiveRecord::RecordInvalid => e
        GraphQL::ExecutionError.new(e.message)
      end
    end
  end
end
