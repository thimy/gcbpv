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
end
