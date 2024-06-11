class ArticlePolicy < ApplicationPolicy
  def index?
    user.present?
  end

  def show?
    user.present?
  end

  def create?
    user.present?
  end

  def update?
    user.admin? || (user.user? && record.user_id == user.id)
  end

  def destroy?
    user.admin? || (user.user? && record.user_id == user.id)
  end

  class Scope < Scope
    def resolve
      if user.admin?
        scope.all
      else
        scope.where(user_id: user.id)
      end
    end
  end
end
