class Payor < ApplicationRecord
  phony_normalize :phone, default_country_code: "FR"

  has_many :students
  has_many :subscription_groups, dependent: :destroy

  accepts_nested_attributes_for :subscription_groups

  def name
    "#{first_name} #{last_name.upcase if last_name.present?}"
  end
end
