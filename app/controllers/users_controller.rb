class UsersController < ApplicationController
  # skip_after_action :verify_authorized, only: [:dashboard]

  def dashboard
    @user = current_user
    authorize @user
    if user_signed_in?
      @events = policy_scope(Event)
      @tasks = policy_scope(Task)
    else
      redirect_to root_path, alert: "You are not authorized to perform this action."
    end
  end
end
