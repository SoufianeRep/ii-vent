class EventPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      # scope.where(user: user)
      scope.all
    end
  end

  # NOTE: Be explicit about which records you allow access to!

  def show?
    true
  end
end
