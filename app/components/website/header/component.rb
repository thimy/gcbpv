# frozen_string_literal: true

class Website::Header::Component < ViewComponent::Base
  delegate :user_signed_in?, to: :helpers
  renders_one :side
  renders_one :bottom

  def initialize(banner: nil)
    @banner = banner
  end
end
