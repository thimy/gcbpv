class Payor < ApplicationRecord
  phony_normalize :phone, default_country_code: "FR"

  has_many :students
  has_many :subscription_groups, dependent: :destroy

  accepts_nested_attributes_for :subscription_groups

  def name
    "#{first_name} #{last_name.upcase if last_name.present?}"
  end

  def full_address
    full_address = []
    full_address << address if address.present?
    full_address << postcode if postcode.present?
    full_address << city if city.present?
    full_address.join(" ")
  end

  def current_subscription_group
    subscription_groups.find_by(season: Config.first.season)
  end
end
