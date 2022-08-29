class EventMembersController < ApplicationController

  def create
    @event = Event.find(params[:event_id])
    event_member_params[:user_id].reject(&:blank?).each do |user_id|
      @event_member = EventMember.create(event_member_params.merge(event: @event, user_id: user_id))
    end
    authorize @event_member
    if @event_member.artist?
      redirect_to event_path(@event, tab: "members", sub_tab: "artists")
    elsif @event_member.staff?
      redirect_to event_path(@event, tab: "members", sub_tab: "staff")
    elsif @event_member.security?
      redirect_to event_path(@event, tab: "members", sub_tab: "security")
    else
      redirect_to event_path(@event, tab: "members")
    end
  end

  private

  def event_member_params
    params.require(:event_member).permit(:permission, :role, user_id: [])
  end
end
