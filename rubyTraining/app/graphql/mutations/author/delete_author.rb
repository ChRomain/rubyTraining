module Mutations
  module Author
    class DeleteAuthor < BaseMutation
      argument :id, ID, required: true

      type Boolean

      # Delete author resolver - return true or error
      def resolve(id:)
        author = ::Author.find(id)
        author.destroy
        true
      rescue ActiveRecord::RecordNotFound => e
        GraphQL::ExecutionError.new("Author not found")
      rescue ActiveRecord::RecordInvalid => e
        GraphQL::ExecutionError.new(e.message)
      end
    end
  end
end
