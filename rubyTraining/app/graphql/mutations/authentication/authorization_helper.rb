module Mutations
  module Authentication
    module AuthorizationHelper
      private

      def authorize_admin_or_author!(author_id)
        user = context[:current_user]
        return if user&.role == 'admin' || (user&.role == 'user' && user&.id == author_id)
        raise GraphQL::ExecutionError, 'You are not authorized to perform this action'
      end
    end
  end
end
