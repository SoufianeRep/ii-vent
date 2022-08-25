class EventMembersController < ApplicationController

  def create
    @event = Event.find(params[:event_id])
    @event_member = EventMember.new(event_member_params.merge(event: @event))
    authorize @event_member
    if @event_member.save
      if @event_member.user.artist?
        redirect_to event_path(@event, tab: "members", sub_tab: "artists")
      elsif @event_member.user.staff?
        redirect_to event_path(@event, tab: "members", sub_tab: "staff")
      elsif @event_member.user.security?
        redirect_to event_path(@event, tab: "members", sub_tab: "security")
      else
        redirect_to event_path(@event, tab: "members")
      end
    else
      redirect_to event_path(@event, tab: "members"), alert: "Could not add member to the event"
    end
  end

  private

  def event_member_params
    params.require(:event_member).permit(:user_id, :permission)
  end
end
