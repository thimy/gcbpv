class SubbedKidWorkshop < ApplicationRecord
  belongs_to :kid_workshop_slot
  belongs_to :subscription

  enum :option, "Confirmé" => 0, "Optionel" => 1

  def student_name
    subscription.student.name
  end

  def workshop_name
    kid_workshop_slot.name
  end
end
