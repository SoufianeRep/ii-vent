class Task < ApplicationRecord
  belongs_to :event
  belongs_to :task, optional: true
  has_many :messages, as: :room
end
