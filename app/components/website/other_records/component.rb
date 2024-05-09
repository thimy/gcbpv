# frozen_string_literal: true

class Website::OtherRecords::Component < ViewComponent::Base
  def initialize(label:)
    @label = label
  end
end
