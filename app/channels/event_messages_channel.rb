class EventMessagesChannel < ApplicationCable::Channel
  def subscribed
    messages = Event.find(params[:id])
    # messages_roles = Event.find(params[:id]).roles
    # stream_from "messages-#{EventMember.find_by(user_id: current_user.id, event_id: params[:id]).role}-#{params[:id]}"

    stream_for messages
    # stream_for messages_roles
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
