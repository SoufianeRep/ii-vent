class Event < ApplicationRecord
  has_many :messages, as: :room
  has_many :tasks

  validates :location, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :name, presence: true, uniqueness: true
  validates :event_status, presence: true
  enum event_status: { upcoming: "upcoming", ongoing: "ongoing", finished: "finished" }
end
