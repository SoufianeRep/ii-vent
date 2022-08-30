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
    # @event.event_members.build
    build_event_members
    authorize @event
  end

  def create
    params[:event][:event_members_attributes] = build_event_member_params
    @event = Event.new(event_params)
    @users = User.all
    authorize @event
    if @event.save
      @organizer = EventMember.create(user: current_user, event: @event, permission: "organizer", role: "manager")
      redirect_to event_path(@event)
    else
      build_event_members
      render :new
    end
  end

  private

  def event_params
    params.require(:event).permit(:name, :location, :start_date, :end_date, :photo, :poster_url, event_members_attributes: [:permission, :role, :user_id])
  end

  def build_event_members
    return if @event.event_members.present?

    @event.event_members.build
  end

  def build_event_member_params
    response = {}
    (0..3).to_a.each do |num|
      role = params[:event][:event_members_attributes][num.to_s][:role]
      permission = params[:event][:event_members_attributes][num.to_s][:permission]
      ids = params[:event][:event_members_attributes][num.to_s]["user_id"].reject(&:blank?)
      if ids.any?
        ids.each do |user_id|
          next_index = response.keys.empty? ? 0 : response.keys.last.to_i + 1
          response[next_index.to_s] = {
            user_id: user_id,
            role: role,
            permission: permission,
          }
        end
      end
    end
    return response
  end
end
