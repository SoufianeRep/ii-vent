class Task < ApplicationRecord
  belongs_to :event
  has_many :tasks, dependent: :destroy
  belongs_to :task, optional: true
  has_many :messages, as: :room
  has_many :task_members, dependent: :destroy

  validates :name, presence: true
  validates :category, presence: true
  validates :status, presence: true
  enum status: { pending: "pending", done: "done", archived: "archived" }
end
