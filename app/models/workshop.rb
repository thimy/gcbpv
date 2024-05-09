class Workshop < ApplicationRecord
  belongs_to :city
  has_and_belongs_to_many :teachers

  validates :name, presence: true
end
