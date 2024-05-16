# frozen_string_literal: true

class Website::Header::Component < ViewComponent::Base
  delegate :user_signed_in?, to: :helpers
end
