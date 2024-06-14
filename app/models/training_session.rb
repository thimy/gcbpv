class TrainingSession < ApplicationRecord
  include WithTime
  belongs_to :training
  has_one_attached :image

  enum :status, "Public" => 0, "Privé" => 1
end
