# frozen_string_literal: true

class Website::Header::Entry::Component < ViewComponent::Base
  def initialize(label:, path:)
    @label = label
    @path = path
  end

  def options
    if current_page?(@path)
      {"aria-current": "page"}
    end
  end
end
