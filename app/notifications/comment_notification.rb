# To deliver this notification:
#
# CommentNotification.with(post: @post).deliver_later(current_user)
# CommentNotification.with(post: @post).deliver(current_user)

class CommentNotification < Noticed::Base
  # Add your delivery methods
  #
  deliver_by :database
  # deliver_by :action_cable
  # deliver_by :email, mailer: "UserMailer"
  # deliver_by :slack
  # deliver_by :custom, class: "MyDeliveryMethod"

  # Add required params
  #
  # param :post

  # Define helper methods to make rendering easier
  #
  def message
    # sender is not recipient
    @sender = EventMember.find_by(user: params[:sender])
    @event = @sender.event
    @message = params[:message]
    "New message from #{params[:sender].full_name} in #{@event.name}"
  end

  # def url
  #   post_path(Message.find(params[:message_id]).room)
  # end
end
