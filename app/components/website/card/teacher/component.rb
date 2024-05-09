# frozen_string_literal: true

class Website::Card::Teacher::Component < ViewComponent::Base
  with_collection_parameter :teacher
  
  def initialize(teacher:)
    @teacher = teacher
  end
end
