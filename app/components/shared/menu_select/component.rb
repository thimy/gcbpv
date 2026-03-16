# frozen_string_literal: true

class Shared::MenuSelect::Component < ViewComponent::Base
  delegate :inline_svg, to: :helpers

  def initialize(title:, links:)
    @title = title
    @links = links
  end
end
