class Payor < ApplicationRecord
  has_many :students
  has_many :subscription_groups

  def name
    "#{first_name} #{last_name}"
  end
end
