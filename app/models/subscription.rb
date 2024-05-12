class Subscription < ApplicationRecord
  belongs_to :student
  has_many :courses
  has_many :workshops
  belongs_to :payor
  belongs_to :season

  accepts_nested_attributes_for :courses
end
