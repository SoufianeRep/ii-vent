class Task < ApplicationRecord
  CATEGORY = ['Music', 'Security', 'Promotion', 'Catering', 'Organization']

  belongs_to :event
  has_many :tasks, dependent: :destroy
  belongs_to :task, optional: true
  has_many :messages, as: :room
  has_many :task_members, dependent: :destroy
  has_many :event_members, through: :task_members

  validates :name, presence: true
  validates :category, presence: true
  validates :status, presence: true
  validates :start, presence: true
  enum status: { pending: "pending", done: "done", archived: "archived" }
end
