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
      Author.all
    end

    def author(id:)
      Author.find(id)
    end

    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    field :articles_by_author, resolver: Queries::ArticlesByAuthor
  end
end
