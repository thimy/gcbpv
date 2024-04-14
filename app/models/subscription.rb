class Subscription < ApplicationRecord
  belongs_to :student
  belongs_to :course
  belongs_to :workshop
  belongs_to :payor
end
