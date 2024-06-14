module Mutations
  module Article
    class CreateArticle < BaseMutation
      include Mutations::Authentication::AuthorizationHelper

      argument :title, String, required: true
      argument :body, String, required: true
      argument :author_id, ID, required: true
      argument :published_at, GraphQL::Types::ISO8601DateTime, required: false

      type Types::ArticleType

      # Create article resolver with auth management - return Article
      def resolve(title:, body:, author_id:, published_at: nil)
        authorize_admin_or_author!(author_id)
        ::Article.create!(title: title, body: body, author_id: author_id, published_at: published_at)
      end
    end
  end
end
