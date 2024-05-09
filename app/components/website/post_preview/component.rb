# frozen_string_literal: true

class Website::PostPreview::Component < ViewComponent::Base
  with_collection_parameter :post

  def initialize(post:)
    @post = post
  end

end
