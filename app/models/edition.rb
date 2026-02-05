class Edition < ApplicationRecord
  has_one_attached :image

  validates :name, presence: true
  validates :format, presence: true
  validates :price, presence: true
  validates :status, presence: true

  enum :status, "Public" => 0, "Privé" => 1
end
