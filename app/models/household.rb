class Household < ApplicationRecord
  include GenerateCsv
  include WithPerson
  phony_normalize :phone, default_country_code: "FR"

  has_one :user
  belongs_to :student, optional: true
  has_many :subscription_groups, dependent: :destroy

  accepts_nested_attributes_for :subscription_groups

  validates :last_name, presence: true
  validates :first_name, presence: true
  validates :city, presence: true

  def students
    subscription_groups.map { |subscription_group|
      subscription_group.subscriptions.map { |subscription|
        subscription.student
      }
    }.flatten.uniq
  end

  def name
    "#{first_name} #{last_name.upcase if last_name.present?}"
  end

  def phones
    [format_phone(phone), format_phone(secondary_phone)].reject(&:blank?).join(" / ")
  end

  def emails
    [email, secondary_email].reject(&:blank?).join(" / ")
  end

  def household_email
    email || user.present? && user.email || nil
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

  def subscription_group(season = nil)
    season ? subscription_groups.find_by(season: season) : subscription_groups.find_by(season: Config.first.season)
  end

  def subscriptions(season = nil)
    subscription_group(season)&.subscriptions
  end

  def redon_agglo?
    is_from_agglo?(Agglomeration.find(1))
  end

  def obc?
    is_from_agglo?(Agglomeration.find(2))
  end

  def agglo
    if redon_agglo?
      Agglomeration.find(1).name
    elsif obc?
      Agglomeration.find(2).name
    else
      "Hors agglo"
    end
  end

  private

  def is_from_agglo?(agglo)
    agglo.cities.find {|agglo_city|
      agglo_city.name == city
    }
  end

  def format_phone(phone_number)
    phone_number && phone_number.phony_formatted(normalize: :FR)
  end
end
