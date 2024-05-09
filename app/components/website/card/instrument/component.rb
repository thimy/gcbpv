# frozen_string_literal: true

class Website::Card::Instrument::Component < ViewComponent::Base
  with_collection_parameter :instrument

  def initialize(instrument:)
    @instrument = instrument
  end
end
