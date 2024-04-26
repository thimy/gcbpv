class Student < ApplicationRecord
  belongs_to :payor, optional: true

  validates :last_name, presence: true
  validates :first_name, presence: true

  enum :gender, "Homme" => 0, "Femme" => 1, "Non-binaire" => 2, "Ne se prononce pas" => 3

  def full_name
    "#{first_name} #{last_name}"
  end
end
