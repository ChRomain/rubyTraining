module Mutations
  module Authentication
    class LogIn < BaseMutation
      argument :email, String, required: true
      argument :password, String, required: true

      field :token, String, null: true
      field :user, Types::UserType, null: true

      # Log in resolver. If success return jwt token
      def resolve(email:, password:)
        user = User.find_by(email: email)
        return GraphQL::ExecutionError.new('Invalid credentials') unless user&.authenticate(password)

        token = JWT.encode({ user_id: user.id }, Rails.application.secret_key_base)
        { token: token, user: user }
      end
    end
  end
end
