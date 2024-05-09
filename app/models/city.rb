class City < ApplicationRecord
  # Cities where the school dispenses classes
  has_many :teachers, through: :slots
  validates :name, presence: true
end
