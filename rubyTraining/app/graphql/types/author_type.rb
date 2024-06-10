module Types
  class AuthorType < Types::BaseObject
    field :id, ID, null: false
    field :email, String, null: false
    field :name, String, null: false
    field :articles, [ArticleType], null: true
  end
end
