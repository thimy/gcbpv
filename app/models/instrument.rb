class Instrument < ApplicationRecord
  has_many :specialties, dependent: :delete_all
  has_many :teachers, through: :specialties
end
