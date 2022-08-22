class TaskMember < ApplicationRecord
  belongs_to :task
  belongs_to :event_memeber
end
