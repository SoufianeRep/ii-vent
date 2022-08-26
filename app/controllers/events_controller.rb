class EventsController < ApplicationController
  def show
    @event = Event.find(params[:id])
    authorize @event
    @artists = @event.event_members.filter { |member| member.user.artist? }
    @staffs = @event.event_members.filter { |member| member.user.staff? }
    @securities = @event.event_members.filter { |member| member.user.security? }
    @markers = [
      {
        lat: @event.latitude,
        lng: @event.longitude
      }
    ]
    @tasks = @event.tasks.where(task_id: nil).order(status: :asc)
    @event_member = EventMember.new
    @users = User.where.not(id: @event.users.map(&:id))
  end

  def new
    @event = Event.new
    authorize @event
  end

  def create
    @event = Event.new(event_params)
    authorize @event
    if @event.save
      @organizer = EventMember.create!(user: current_user, event: @event, permission: "organizer", role: "manager")
      redirect_to event_path(@event)
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def event_params
    params.require(:event).permit(:name, :location, :start_date, :end_date, :poster_url)
  end
end
