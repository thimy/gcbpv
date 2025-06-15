# frozen_string_literal: true

class Shared::MenuSelect::Component < ViewComponent::Base
  def initialize(title:, links:)
    @title = title
    @links = links
  end
end
