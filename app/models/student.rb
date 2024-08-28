class Student < ApplicationRecord
  phony_normalize :phone, default_country_code: "FR"

  belongs_to :payor, optional: true
  has_many :subscriptions, dependent: :destroy
  has_many :subscription_groups, through: :subscriptions
  has_many :courses, through: :subscriptions
  has_many :subbed_workshops, through: :subscriptions
  has_many :workshops, through: :subbed_workshops

  accepts_nested_attributes_for :subscriptions

  validates :last_name, presence: true
  validates :first_name, presence: true

  enum :gender, "Ne se prononce pas" => 0, "Homme" => 1, "Femme" => 2, "Non-binaire" => 3

  def name
    "#{first_name} #{last_name.upcase}"
  end
end
