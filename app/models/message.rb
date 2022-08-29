class Message < ApplicationRecord
  # Chatroom
  belongs_to :event_member # like the user_id
  belongs_to :room, polymorphic: true # messegable

  # This is like the room_id for multiple rooms
  validates :room_type, presence: true, inclusion: { in: ['Task', 'Event'] }
end
