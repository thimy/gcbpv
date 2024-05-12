class Student < ApplicationRecord
  belongs_to :payor, optional: true

  validates :last_name, presence: true
  validates :first_name, presence: true

  enum :gender, "Ne se prononce pas" => 0, "Homme" => 1, "Femme" => 2, "Non-binaire" => 3

  def name
    "#{first_name} #{last_name}"
  end
end
