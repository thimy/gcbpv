# frozen_string_literal: true

class Website::Bogue::Sidebar::Component < ViewComponent::Base
  def initialize(bogue:)
    @bogue = bogue
    @pages = @bogue.pages
  end
end
