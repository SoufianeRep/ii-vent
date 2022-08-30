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
    @tasks = @event.tasks.where(task_id: nil).order(done: :asc)
    @event_member = EventMember.new
    @users = User.where.not(id: @event.users.map(&:id))
    @message = Message.new
  end

  def new
    @event = Event.new
    @users = User.all
    @event.event_members.build
    authorize @event
  end

  def create
    build_event_member_params
    @event = Event.new(event_params)
    @users = User.all
    authorize @event
    if @event.save
      @organizer = EventMember.create(user: current_user, event: @event, permission: "organizer", role: "manager")
      redirect_to event_path(@event)
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def event_params
    params.require(:event).permit(:name, :location, :start_date, :end_date, :photo, :poster_url, event_members_attributes: [:permission, :role, :user_id])
  end

  def build_event_member_params
    role = params[:event][:event_members_attributes]["0"][:role]
    permission = params[:event][:event_members_attributes]["0"][:permission]
    ids = params[:event][:event_members_attributes]["0"]["user_id"].reject(&:blank?)
    if ids.any?
      ids.each_with_index do |user_id, index|
        params[:event][:event_members_attributes][index.to_s] = {
          user_id: user_id,
          role: role,
          permission: permission,
        }
      end
    else
      params[:event][:event_members_attributes] = {}
    end
  end
end
