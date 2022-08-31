class EventPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      # scope.where(user: user)
      user.events
      # scope.all
    end
  end

  def show?
    true
  end

  def new?
    true
  end

  def create?
    true
  end

  def update?
    record.event_members.find_by(user: user)
  end
end
