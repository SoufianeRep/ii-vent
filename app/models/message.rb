class Message < ApplicationRecord
  belongs_to :event_member
  belongs_to :room, polymorphic: true

  validates :room_type, presence: true, inclusion: { in: ['Task', 'Event'] }
end
