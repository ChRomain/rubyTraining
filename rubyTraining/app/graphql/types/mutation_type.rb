# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    field :sign_up, mutation: Mutations::SignUp
    field :log_in, mutation: Mutations::LogIn
    # TODO: remove me
#     field :test_field, String, null: false,
#       description: "An example field added by the generator"
#     def test_field
#       "Hello World"
#     end

    # Author mutations
    field :create_author, AuthorType, null: false do
      argument :name, String, required: true
      argument :email, String, required: true
    end

    def create_author(name:, email:)
      Author.create(name: name, email: email)
    end

    field :update_author, AuthorType, null: false do
      argument :id, ID, required: true
      argument :name, String, required: false
      argument :email, String, required: false
    end

    def update_author(id:, name: nil, email: nil)
      author = Author.find(id)
      author.update(name: name, email: email)
      author
    end

    field :delete_author, Boolean, null: false do
      argument :id, ID, required: true
    end

    def delete_author(id:)
      author = Author.find(id)
      author.destroy
      true
    end

    # Article mutations
    field :create_article, ArticleType, null: false do
      argument :title, String, required: true
      argument :body, String, required: true
      argument :author_id, ID, required: true
      argument :published_at, GraphQL::Types::ISO8601DateTime, required: false
    end

    def create_article(title:, body:, author_id:, published_at: nil)
      authorize_admin_or_author!(author_id)
      Article.create(title: title, body: body, author_id: author_id, published_at: published_at)
    end

    field :update_article, ArticleType, null: false do
      argument :id, ID, required: true
      argument :title, String, required: false
      argument :body, String, required: false
      argument :author_id, ID, required: false
      argument :published_at, GraphQL::Types::ISO8601DateTime, required: false
    end

    def update_article(id:, title: nil, body: nil, author_id: nil, published_at: nil)
      article = Article.find(id)
      authorize_admin_or_author!(article.author_id)
      article.update!(title: title, body: body, author_id: author_id, published_at: published_at)
      article
    end

    field :delete_article, Boolean, null: false do
      argument :id, ID, required: true
    end

    def delete_article(id:)
      article = Article.find(id)
      authorize_admin_or_author!(article.author_id)
      article.destroy!
      true
    end

    private

    def authorize_admin_or_author!(author_id)
      user = context[:current_user]
      return if user&.role == 'admin' || (user&.role == 'user' && user&.id == author_id)
      raise GraphQL::ExecutionError, 'You are not authorized to perform this action'
    end
  end
end

