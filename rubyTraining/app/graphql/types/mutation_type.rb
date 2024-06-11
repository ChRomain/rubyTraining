# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    require_dependency 'types/user_type'
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
      authenticate_user!
      article = Article.new(
        title: title,
        body: body,
        author_id: author_id,
        published_at: published_at,
        user: context[:current_user]
      )
      authorize article, :create?
      article.save!
      article
    end

    field :update_article, ArticleType, null: false do
      argument :id, ID, required: true
      argument :title, String, required: false
      argument :body, String, required: false
      argument :author_id, ID, required: false
      argument :published_at, GraphQL::Types::ISO8601DateTime, required: false
    end

    def update_article(id:, title: nil, body: nil, author_id: nil, published_at: nil)
      authenticate_user!
      article = Article.find(id)
      authorize article, :update?
      article.update!(
        title: title,
        body: body,
        author_id: author_id,
        published_at: published_at
      )
      article
    end

    field :delete_article, Boolean, null: false do
      argument :id, ID, required: true
    end

    def delete_article(id:)
      authenticate_user!
      article = Article.find(id)
      authorize article, :destroy?
      article.destroy
      true
    end

    # User mutations
    field :sign_up, UserType, null: false do
      argument :name, String, required: true
      argument :email, String, required: true
      argument :password, String, required: true
    end

    def sign_up(name:, email:, password:)
      user = User.create(name: name, email: email, password: password)
      if user.persisted?
        user
      else
        raise GraphQL::ExecutionError, "Failed to sign up: #{user.errors.full_messages.join(', ')}"
      end
    end

    field :log_in, String, null: false do
      argument :email, String, required: true
      argument :password, String, required: true
    end

    def log_in(email:, password:)
      user = User.find_for_authentication(email: email)
      if user&.valid_password?(password)
        JsonWebToken.encode(user_id: user.id)
      else
        raise GraphQL::ExecutionError, 'Invalid email or password'
      end
    end

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

