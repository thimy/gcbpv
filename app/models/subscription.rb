class Subscription < ApplicationRecord
  belongs_to :student
  has_many :courses
  has_many :workshops
  belongs_to :payor
end
