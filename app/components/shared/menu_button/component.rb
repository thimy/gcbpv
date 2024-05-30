# frozen_string_literal: true

class Shared::MenuButton::Component < ViewComponent::Base
  delegate :inline_svg, to: :helpers
end
