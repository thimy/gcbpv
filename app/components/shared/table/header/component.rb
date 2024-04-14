# frozen_string_literal: true

class Shared::Table::Header::Component < ViewComponent::Base
  renders_many :columns, "ColumnComponent"

  class ColumnComponent < ViewComponent::Base
    def initialize(name:, id: nil, show_label: true, **options)
      @name = name
      @id = id
      @show_label = show_label
      @options = options || {}
    end

    def displayed_content
      return unless @show_label
      content.present? ? content : @name.humanize.titleize
    end

    def call
      content_tag "th", displayed_content, {class: "cell-#{@name}", **@options}
    end
  end
end
