class Course < ApplicationRecord
  belongs_to :instrument
  belongs_to :slot
  has_many :teachers, through: :slots
  has_many :subbed_courses
  has_many :subscriptions, through: :subbed_courses
end

