# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    # Articles queries
    field :articles, [ArticleType], null: false
    field :article, ArticleType, null: false do
      argument :id, ID, required: true
    end

    def articles
      Article.all
    end

    def article(id:)
      Article.find(id)
    end

    # Authors queries
    field :authors, [AuthorType], null: false
    field :author, AuthorType, null: false do
      argument :id, ID, required: true
    end

    def authors
      authorize_admin!
      Author.all
    end

    def author(id:)
      authorize_admin!
      Author.find(id)
    end

    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    field :articles_by_author, resolver: Queries::ArticlesByAuthor

    private

    def authorize_admin!
      user = context[:current_user]
      raise GraphQL::ExecutionError, 'You are not authorized to perform this action' unless user&.role == 'admin'
    end
  end
end
