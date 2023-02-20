# frozen_string_literal: true

class Global::CardComponent < ViewComponent::Base
  def initialize(title:, url:)
    @title = title
    @url = url
  end

end
