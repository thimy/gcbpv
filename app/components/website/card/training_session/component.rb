# frozen_string_literal: true

class Website::Card::TrainingSession::Component < ViewComponent::Base
  with_collection_parameter :session
  def initialize(session:)
    @session = session
  end

end
