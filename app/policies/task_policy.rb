class TaskPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      user.tasks
      # scope.all
      # scope.where(user: user)
    end
  end

  def create?
    organizers = record.event_members.select { |member| member.permission == 'organizer' }
    organizers.any? { |member| member == user }
  end
end
