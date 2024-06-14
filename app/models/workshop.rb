class Workshop < ApplicationRecord
  include WithTime

  has_and_belongs_to_many :teachers
  has_many :workshop_slots
  has_many :cities, through: :workshop_slots

  accepts_nested_attributes_for :workshop_slots

  validates :name, presence: true

  enum :status, "Public" => 0, "Privé" => 1

  scope :active, -> {where(status: 0)}
end
