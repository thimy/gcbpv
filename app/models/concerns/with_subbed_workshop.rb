module WithSubbedWorkshop
  extend ActiveSupport::Concern

  def student_name
    subscription.student.name
  end

  def is_option?
    option == "Optionel" || subscription.subscription_group.status == 0
  end
end
