# frozen_string_literal: true

class Shared::Table::Header::Component < ViewComponent::Base
  renders_many :columns, ->(name:, **options) do
    Shared::Table::Column::Component.new(name: name, **options_with_sortable(name, options))
  end

  def initialize(sort: nil, direction: nil, base_request_params: {})
    @sort = sort
    @direction = direction
    @base_request_params = base_request_params
  end

  private

  def options_with_sortable(name, options)
    if @sort == name
      options[:sort_direction] = @direction
    end

    if @base_request_params.present?
      options[:base_request_params] = @base_request_params
    end

    options
  end
end
