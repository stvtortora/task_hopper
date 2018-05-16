class Day < ApplicationRecord
  validates :title, presence: true

  has_many :time_slots
end
