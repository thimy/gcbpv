class Course < ApplicationRecord
  has_one :instrument
  has_many :slots
  has_many :teachers, through: :slots
end

