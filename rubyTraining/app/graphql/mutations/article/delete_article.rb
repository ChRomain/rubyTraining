module Mutations
  module Article
    class DeleteArticle < BaseMutation
      include Mutations::Authentication::AuthorizationHelper

      argument :id, ID, required: true

      type Boolean

      def resolve(id:)
        article = ::Article.find(id)
        authorize_admin_or_author!(article.author_id)
        article.destroy!
        true
      end
    end
  end
end
