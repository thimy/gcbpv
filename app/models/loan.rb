class Loan < ApplicationRecord
  belongs_to :subscription

  validates :subscription, presence: true
  validates :instrument, presence: true
  validates :cost, presence: true
end
