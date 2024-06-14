module Mutations
  module Article
    class DeleteArticle < BaseMutation
      include Mutations::Authentication::AuthorizationHelper

      argument :id, ID, required: true

      type Boolean

      # Delete article resolver with auth management - Return true if success
      def resolve(id:)
        article = ::Article.find(id)
        authorize_admin_or_author!(article.author_id)
        article.destroy!
        true
      end
    end
  end
end
