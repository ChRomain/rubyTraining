# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    # Articles queries
    field :articles, [ArticleType], null: false

    def articles
      Article.all
    end

    field :article, ArticleType, null: false do
      argument :id, ID, required: true
    end

    def article(id:)
      Article.find(id)
    end

    # Authors queries
    field :authors, [AuthorType], null: false

    def authors
      authorize_admin!
      Author.all
    end

    field :author, AuthorType, null: false do
      argument :id, ID, required: true
    end

    def author(id:)
      authorize_admin!
      Author.find(id)
    end

    field :articles_by_author, resolver: Queries::ArticlesByAuthor

    private

    def authorize_admin!
      user = context[:current_user]
      raise GraphQL::ExecutionError, 'You are not authorized to perform this action' unless user&.role == 'admin'
    end
  end
end
