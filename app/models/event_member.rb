class EventMember < ApplicationRecord
  belongs_to :user
  belongs_to :event

  validates :user_id, uniqueness: { scope: :event_id, message: "Cannot have multiples of the same user in an event" }
end
