class Event < ApplicationRecord
  geocoded_by :location
  after_validation :geocode, if: :will_save_change_to_location?

  has_many :messages, as: :room
  has_many :tasks

  has_one_attached :photo

  validates :location, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :name, presence: true, uniqueness: true
  validates :event_status, presence: true
  enum event_status: { upcoming: "upcoming", ongoing: "ongoing", finished: "finished" }
end
