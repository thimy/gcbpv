class KidWorkshop < ApplicationRecord
  enum :workshop_type, "Éveil" => 0, "Découverte" => 1
  enum :status, "Archivé" => 0, "Public" => 1

  scope :visible, -> { where(status: "Public") }
end
