# frozen_string_literal: true

class Website::Card::Event::Component < ViewComponent::Base
  with_collection_parameter :event
  
  def initialize(event:, inline: false)
    @event = event
    @inline = inline
  end
end
