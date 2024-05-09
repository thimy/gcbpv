# frozen_string_literal: true

class Website::Card::Workshop::Component < ViewComponent::Base
  with_collection_parameter :workshop

  def initialize(workshop:)
    @workshop = workshop
  end
end
