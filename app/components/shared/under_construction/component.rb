# frozen_string_literal: true

class Shared::UnderConstruction::Component < ViewComponent::Base
  delegate :inline_svg, to: :helpers
end
