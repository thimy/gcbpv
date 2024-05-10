# frozen_string_literal: true

class Website::Card::Edition::Component < ViewComponent::Base
  with_collection_parameter :edition

  def initialize(edition:)
    @edition = edition
  end
end
