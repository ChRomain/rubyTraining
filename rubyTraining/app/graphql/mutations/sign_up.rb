module Mutations
  class SignUp < BaseMutation
    class RoleEnum < GraphQL::Schema::Enum
      value "admin", "Admin role"
      value "user", "User role"
    end
    argument :email, String, required: true
    argument :password, String, required: true
    argument :role, RoleEnum, required: true

    type Types::UserType

    def resolve(email:, password:, role:)
      User.create!(email: email, password: password, role: role)
    rescue ActiveRecord::RecordInvalid => e
      GraphQL::ExecutionError.new(e.message)
    end
  end
end
