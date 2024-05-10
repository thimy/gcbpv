# frozen_string_literal: true

class Website::Event::Card::Component < ViewComponent::Base
  with_collection_parameter :event
  
  def initialize(event:, path:)
    @event = event
    @path = path
  end

end
