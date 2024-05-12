class Course < ApplicationRecord
  belongs_to :instrument
  belongs_to :slot
  has_many :teachers, through: :slots
end

