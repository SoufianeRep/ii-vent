class Message < ApplicationRecord
  # Chatroom
  belongs_to :event_member # like the user_id
  belongs_to :room, polymorphic: true # messegable

  after_create_commit :notify_recipient
  before_destroy :cleanup_notifications

  # This is like the room_id for multiple rooms
  validates :room_type, presence: true, inclusion: { in: ['Task', 'Event'] }

  def sender?(user)
    user == event_member.user
  end

  private

  def notify_recipient
    # we need to create a notification that attaches to all users except for the sender
    CommentNotification.with(message: self).deliver_later(event_member.user)
  end

  def cleanup_notifications
    notifications_as_message.destroy_all
  end
end
