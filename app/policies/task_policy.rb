class TaskPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      user.tasks
      # scope.all
      # scope.where(user: user)
    end
  end
end
