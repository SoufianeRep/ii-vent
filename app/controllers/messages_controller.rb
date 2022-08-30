class MessagesController < ApplicationController
  # GET /messages

  # GET /events/:id/messages/:id
  def show
    @event = Event.find(params[:event_id])
    @message = Message.find(params[:id])
    @messages = @event.messages
    @message = Message.new
  end

  # POST /messages
  def create
    # content, event_member, room
    @message = Message.new(messages_params)
    @event = Event.find(params[:event_id])
    @message.room = @event
    @event_member = @event.event_members.find_by(user: current_user)
    @message.event_member = @event_member
    authorize @message
    @message.save
    EventMessagesChannel.broadcast_to(
      @event,
      message: render_to_string(partial: "shared/event_message", locals: { message: @message }),
      sender_id: @message.event_member.user.id
    )
    head :ok
  end

  private

  def messages_params
    params.require(:message).permit(:content)
  end
end
