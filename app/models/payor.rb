  class Payor < ApplicationRecord
  has_many :students
  has_many :subscription_groups

  accepts_nested_attributes_for :subscription_groups

  def name
    "#{first_name} #{last_name.upcase}"
  end
end
