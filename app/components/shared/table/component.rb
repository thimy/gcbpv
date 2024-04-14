# frozen_string_literal: true

class Shared::Table::Component < ViewComponent::Base
  attr_reader :css_classes
  renders_one :header, Shared::Table::Header::Component
  renders_many :rows, Shared::Table::Row::Component

  def initialize(css_classes: "")
    @css_classes = css_classes
  end
end
