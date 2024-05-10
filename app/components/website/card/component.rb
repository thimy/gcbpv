# frozen_string_literal: true

class Website::Card::Component < ViewComponent::Base
  with_collection_parameter :record
  def initialize(record:, path:)
    @record = record
    @path = path
  end

end
