class UsersController < ApplicationController
  # skip_after_action :verify_authorized, only: [:dashboard]

  def dashboard
    @user = current_user
    authorize @user
    if user_signed_in?
      @events = policy_scope(Event).where('start_date > ?', Date.yesterday).order(start_date: :asc)
      @tasks = policy_scope(Task).where(done: false).order(end: :asc)

      # Scope your query to the dates being shown:
      start_date = params.fetch(:start_date, Date.today).to_date

      # For a monthly view:
      @current_month_events = Event.where(start_date: start_date.beginning_of_month.beginning_of_week..start_date.end_of_month.end_of_week)
      # raise
    else
      redirect_to root_path, alert: "You are not authorized to perform this action."
    end
  end

  def calendar
    @user = current_user
    authorize @user

    if user_signed_in?
      @events = policy_scope(Event).order(start_date: :asc)
      @tasks = policy_scope(Task).order(end: :asc)

      # Scope your query to the dates being shown:
      start_date = params.fetch(:start_date, Date.today).to_date

      # For a monthly view:
      @current_month_events = Event.where(start_date: start_date.beginning_of_month.beginning_of_week..start_date.end_of_month.end_of_week)
      # raise
    else
      redirect_to root_path, alert: "You are not authorized to perform this action."
    end
  end
end
