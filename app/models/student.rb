class Student < ApplicationRecord
  include WithPerson
  phony_normalize :phone, default_country_code: "FR"

  belongs_to :household, optional: true
  has_many :subscriptions, dependent: :destroy
  has_many :subscription_groups, through: :subscriptions
  has_many :courses, through: :subscriptions
  has_many :subbed_workshops, through: :subscriptions
  has_many :workshops, through: :subbed_workshops

  accepts_nested_attributes_for :subscriptions

  validates :last_name, presence: true
  validates :first_name, presence: true

  # validates :birth_year, numericality: {only_integer: true, greater_than_or_equal_to: Config.first.season.start_year - 120, less_than_or_equal_to: Config.first.season.start_year - 2, message: "Année de naissance invalide"}

  enum :gender, "Ne se prononce pas" => 0, "Homme" => 1, "Femme" => 2, "Non-binaire" => 3, "Autre" => 4
  enum :age_type, "Non renseigné" => 0, "Jeunes" => 1, "Adultes" => 2

  attribute :age_type, :integer

  scope :youth, -> { "birth_year > #{Config.first.season.start_year - 18}" }
  scope :adults, -> { "birth_year <= #{Config.first.season.start_year - 18}" }
  scope :undefined_age, -> { where(birth_year: nil) }

  def name
    "#{first_name} #{last_name.upcase}"
  end

  def age_type
    age = Config.first.season.start_year - birth_year if birth_year.present?
    return Student.age_types["Non renseigné"] if age.nil? 
    if age > 18
      Student.age_types["Adultes"]
    else 
      Student.age_types["Jeunes"]
    end
  end

  def address_or_household_address
    address.presence || subscriptions.last&.subscription_group&.household&.address
  end

  def postcode_or_household_postcode
    postcode.presence || subscriptions.last&.subscription_group&.household&.postcode
  end

  def city_or_household_city
    city.presence || subscriptions.last&.subscription_group&.household&.city
  end

  def email_or_household_email
    email.presence || subscriptions.last&.subscription_group&.household&.emails
  end

  def phone_or_household_phone
    phone.presence || subscriptions.last&.subscription_group&.household&.phones
  end

  def uses_household_info?
    address.nil? && postcode.nil? && city.nil? && email.nil? && phone.nil?
  end
end
