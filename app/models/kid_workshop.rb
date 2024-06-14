class KidWorkshop < ApplicationRecord
  has_many :kid_workshop_slots

  accepts_nested_attributes_for :kid_workshop_slots

  enum :workshop_type, "Éveil" => 0, "Découverte" => 1, "Parent-Enfant" => 2
  enum :status, "Public" => 0, "Privé" => 1

  scope :visible, -> { where(status: "Public") }
end
