# frozen_string_literal: true

class Website::HeroCard::Component < ViewComponent::Base
  def initialize(title:, url:, css_classes: "")
    @title = title
    @url = url
    @css_classes = "hero-card #{css_classes}"
  end
end
