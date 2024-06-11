# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    # TODO: remove me
#     field :test_field, String, null: false,
#       description: "An example field added by the generator"
#     def test_field
#       "Hello World!"
#     end

#     field :node, Types::NodeType, null: true, description: "Fetches an object given its ID." do
#       argument :id, ID, required: true, description: "ID of the object."
#     end
#
#     def node(id:)
#       context.schema.object_from_id(id, context)
#     end
#
#     field :nodes, [Types::NodeType, null: true], null: true, description: "Fetches a list of objects given a list of IDs." do
#       argument :ids, [ID], required: true, description: "IDs of the objects."
#     end
#
#     def nodes(ids:)
#       ids.map { |id| context.schema.object_from_id(id, context) }
#     end

    # Articles queries
    field :articles, [ArticleType], null: false
    field :article, ArticleType, null: false do
      argument :id, ID, required: true
    end

    def articles
      authenticate_user!
      ArticlePolicy::Scope.new(context[:current_user], Article).resolve
    end

    def article(id:)
      authenticate_user!
      article = Article.find(id)
      authorize(article, :show?)
      article
    end

    # Authors queries
    field :authors, [AuthorType], null: false
    field :author, AuthorType, null: false do
      argument :id, ID, required: true
    end

    def authors
      authenticate_user!
      Author.all
    end

    def author(id:)
      authenticate_user!
      Author.find(id)
    end

    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    field :articles_by_author, resolver: Queries::ArticlesByAuthor

    private

    def authenticate_user!
      raise GraphQL::ExecutionError, "You need to log in to perform this action" unless context[:current_user]
    end

    def authorize(record, query)
      policy = Pundit.policy!(context[:current_user], record)
      unless policy.public_send(query)
        raise GraphQL::ExecutionError, "You are not authorized to perform this action"
      end
    end
  end
end
