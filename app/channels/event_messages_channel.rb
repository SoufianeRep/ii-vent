class EventMessagesChannel < ApplicationCable::Channel
  def subscribed
    messages = Event.find(params[:id])
    # stream_from "messages-#{EventMember.find_by(user_id: current_user.id, event_id: params[:id]).role}-#{params[:id]}"
    stream_for messages
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
