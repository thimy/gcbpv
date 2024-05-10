# frozen_string_literal: true

class Website::Card::Training::Component < ViewComponent::Base
  with_collection_parameter :training
  
  def initialize(training:)
    @training = training
  end
end
