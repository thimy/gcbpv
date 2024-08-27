class SubbedWorkshop < ApplicationRecord
  belongs_to :workshop_slot
  belongs_to :subscription

  enum :option, "Confirmé" => 0, "Optionel" => 1

  scope :registered, -> {joins(:subscription).where(subscription: Subscription.registered)}
  scope :inquired, -> {joins(:subscription).where(subscription: Subscription.inquired)}

  def student_name
    subscription.student.name
  end

  def workshop_name
    workshop_slot.name
  end

  def is_option?
    option == "Optionel" || subscription.subscription_group.status == 0
  end
end
