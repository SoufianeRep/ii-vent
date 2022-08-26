class UsersController < ApplicationController
  # skip_after_action :verify_authorized, only: [:dashboard]

  def dashboard
    @user = current_user
    authorize @user
    if user_signed_in?
      @events = policy_scope(Event).order(start_date: :asc)
      @tasks = policy_scope(Task).order(end: :asc)

      # end is throwing an error because it is a reserved word in Rails - need to change in Task model
    else
      redirect_to root_path, alert: "You are not authorized to perform this action."
    end
  end
end
