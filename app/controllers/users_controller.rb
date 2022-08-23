class UsersController < ApplicationController
  skip_after_action :verify_authorized, only: [:dashboard]

  def dashboard
    # @events = policy_scope(Event)
  end
end
