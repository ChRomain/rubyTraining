# frozen_string_literal: true
module Types
  class MutationType < Types::BaseObject
    # Authentication mutations
    field :sign_up, mutation: Mutations::Authentication::SignUp
    field :log_in, mutation: Mutations::Authentication::LogIn

    # Author mutations
    field :create_author, mutation: Mutations::Author::CreateAuthor
    field :update_author, mutation: Mutations::Author::UpdateAuthor
    field :delete_author, mutation: Mutations::Author::DeleteAuthor

    # Article mutations
    field :create_article, mutation: Mutations::Article::CreateArticle
    field :update_article, mutation: Mutations::Article::UpdateArticle
    field :delete_article, mutation: Mutations::Article::DeleteArticle
  end
end

