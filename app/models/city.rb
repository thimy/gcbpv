class City < ApplicationRecord
  # Cities where the school dispenses classes
  has_many :teachers, through: :slots
  has_many :workshop_slots
  has_many :workshops, through: :workshops
  validates :name, presence: true
end
