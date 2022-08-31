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
    @tasks = @event.tasks.where(task_id: nil).order(updated_at: :desc)
    @event_member = EventMember.new
    @users = User.where.not(id: @event.users.map(&:id))
    @message = Message.new
  end

  def new
    @event = Event.new
    @users = User.all
    build_event_members
    authorize @event
  end

  def create
    params[:event][:event_members_attributes] = build_event_member_params
    @event = Event.new(event_params)
    @users = User.all
    authorize @event
    if @event.save
      @timetable = Task.new(name: "Timetable", description: "Set times for this event", category: "music", start: @event.start_date, end: @event.end_date, timetable: true)
      @timetable.event = @event
      @timetable.save
      @gear = Task.new(name: "Gear", description: "Gear available for this event", category: "music", start: @event.start_date, end: @event.end_date, gear: true)
      @gear.event = @event
      raise
      @event.save
      @organizer = EventMember.create(user: current_user, event: @event, permission: "organizer", role: "manager")
      redirect_to event_path(@event)
    else
      build_event_members
      redirect_to new_event_path, alert: "Missing field input"
    end
  end

  def update
    @event = Event.find(params[:id])
    @event.update(event_params)
    authorize @event
    redirect_to event_path(@event)
  end

  private

  def event_params
    params.require(:event).permit(:name, :location, :start_date, :end_date, :photo, :poster_url, event_members_attributes: [:permission, :role, :user_id], files: [])
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
