class TaskMember < ApplicationRecord
  belongs_to :task
  belongs_to :event_member

  validates :task_id, uniqueness: { scope: :event_member_id, message: "Cannot have the same member twice in the task" }
end
