class Event < ApplicationRecord
  geocoded_by :location
  after_validation :geocode, if: :will_save_change_to_location?

  has_many :messages, as: :room, dependent: :destroy
  has_many :tasks, dependent: :destroy
  has_many :event_members, dependent: :destroy
  accepts_nested_attributes_for :event_members
  has_many :users, through: :event_members
  has_one_attached :photo

  validates :location, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :name, presence: true, uniqueness: true
  validates :event_status, presence: true
  enum event_status: { upcoming: "upcoming", ongoing: "ongoing", finished: "finished" }

  def start_time
    self.start_date
  end

  def end_time
    self.end_date
  end

  def time
    "#{start_time.strftime('%I:%M %p')} - #{end_time.strftime('%I:%M %p')}"
  end
end
