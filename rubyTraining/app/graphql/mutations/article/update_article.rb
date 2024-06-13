module Mutations
  module Article
    class UpdateArticle < BaseMutation
      include Mutations::Authentication::AuthorizationHelper

      argument :id, ID, required: true
      argument :title, String, required: false
      argument :body, String, required: false
      argument :author_id, ID, required: false
      argument :published_at, GraphQL::Types::ISO8601DateTime, required: false

      type Types::ArticleType

      def resolve(id:, title: nil, body: nil, author_id: nil, published_at: nil)
        article = ::Article.find(id)
        authorize_admin_or_author!(article.author_id)
        article.update!(title: title, body: body, author_id: author_id, published_at: published_at)
        article
      end
    end
  end
end
