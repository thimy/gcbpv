class SubbedWorkshop < ApplicationRecord
  belongs_to :workshop_slot
  belongs_to :subscription


  enum :option, "Confirmé" => 0, "Optionel" => 1

  def student_name
    subscription.student.name
  end

  def workshop_name
    workshop_slot.name
  end
end
