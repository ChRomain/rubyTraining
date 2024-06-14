module Mutations
  module Authentication
    class SignUp < BaseMutation
      class RoleEnum < GraphQL::Schema::Enum
        value "admin", "Admin role"
        value "user", "User role"
      end
      argument :email, String, required: true
      argument :password, String, required: true
      argument :role, RoleEnum, required: true

      type Types::UserType

      # Sign Up resolver - Return User if success.
      def resolve(email:, password:, role:)
        User.create!(email: email, password: password, role: role)
      rescue ActiveRecord::RecordInvalid => e
        GraphQL::ExecutionError.new(e.message)
      end
    end
  end
end
