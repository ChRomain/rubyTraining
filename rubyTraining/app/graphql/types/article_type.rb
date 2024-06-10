module Types
  class ArticleType < Types::BaseObject
    field :id, ID, null: false
    field :body, String, null: false
    field :author, AuthorType, null: false
    field :title, String, null: false
    field :published_at, GraphQL::Types::ISO8601DateTime, null: true
  end
end
