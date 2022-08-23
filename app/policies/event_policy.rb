class EventPolicy < ApplicationPolicy
  class Scope < Scope
  end
  def show?
    true
  end
end
