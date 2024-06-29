class Course < ApplicationRecord
  belongs_to :instrument
  belongs_to :slot
  has_many :teachers, through: :slots
  belongs_to :subscription

  enum :option, "Confirmé" => 0, "Optionel" => 1

  def name
    "#{instrument.name} - #{slot.name}"
  end
end
