class EventMember < ApplicationRecord
  belongs_to :user
  belongs_to :event
  has_many :task_members
  has_many :tasks, through: :task_members

  validates :user_id, uniqueness: { scope: :event_id, message: "Cannot have multiples of the same user in an event" }
  validates :permission, presence: true
  enum permission: { organizer: 'organizer', member: 'member' }
  validates :role, presence: true
  enum role: { manager: "manager", artist: "artist", security: "security", staff: "staff" }
end
