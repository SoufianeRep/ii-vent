class Event < ApplicationRecord
  has_many :messages, as: :room
  has_many :tasks
end
