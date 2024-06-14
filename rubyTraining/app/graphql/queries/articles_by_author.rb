module Queries
  class ArticlesByAuthor < GraphQL::Schema::Resolver
    argument :author_id, ID, required: true

    type [Types::ArticleType], null: false

    # Return list of article linked to a specific author
    def resolve(author_id:)
      Article.where(author_id: author_id)
    end
  end
end
