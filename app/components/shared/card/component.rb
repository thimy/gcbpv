# frozen_string_literal: true

class Shared::Card::Component < ViewComponent::Base
  def initialize(title:, url:, css_classes: "")
    @title = title
    @url = url
    @css_classes = "card #{css_classes}"
  end
end
