class City < ApplicationRecord
  # Cities where the school dispenses classes
  has_many :slots
  has_many :teachers, through: :slots
  has_many :workshop_slots
  has_many :workshops, through: :workshops
  validates :name, presence: true

  enum :status, "Public" => 0, "Privé" => 1
end
