# frozen_string_literal: true

class Website::OtherTeachers::Component < ViewComponent::Base
  def initialize(teachers:)
    @teachers = teachers
  end
end
