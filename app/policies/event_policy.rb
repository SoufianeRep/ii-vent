class EventPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      # scope.where(user: user)
      scope.all
    end
  end

  def show?
    true
  end
end
