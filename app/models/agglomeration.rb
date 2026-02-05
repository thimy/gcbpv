class Agglomeration < ApplicationRecord
  has_many :cities

  validates :name, presence: true
end
