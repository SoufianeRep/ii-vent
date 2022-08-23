class EventPolicy < ApplicationPolicy
  class Scope < Scope

  end
  
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end


  def show?
    true
  end
end
