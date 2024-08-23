# frozen_string_literal: true

class Shared::Table::Component < ViewComponent::Base
  attr_reader :css_classes, :options
  renders_one :header, Shared::Table::Header::Component
  renders_many :rows, Shared::Table::Row::Component
  renders_one :pagination, Shared::Pagination::Component
  renders_one :empty_state
  renders_one :empty_state_with_header

  def initialize(css_classes: "", **options)
    @css_classes = css_classes
    @options = options || {}
  end
end
