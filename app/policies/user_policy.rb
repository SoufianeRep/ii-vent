class UserPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.all
    end
  end

  def dashboard?
    true
  end
end
# Not sure why #dashboard true was not working - also is UserPolicy the correct policy for the dashboard?
