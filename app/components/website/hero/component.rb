# frozen_string_literal: true

class Website::Hero::Component < ViewComponent::Base
  def initialize(title:, subtitle: nil)
    @title = title
    @subtitle = subtitle
  end
end
