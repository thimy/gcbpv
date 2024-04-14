# frozen_string_literal: true

class Shared::Table::Row::Component < ViewComponent::Base
  renders_many :cells, "CellComponent"

  def initialize(link_url: nil)
    @link_url = link_url
  end

  class CellComponent < ViewComponent::Base
    def initialize(name:, id: nil, **options)
      @name = name
      @id = id
      @options = options || {}
    end

    def call
      content_tag "td", content, {class: "cell-#{@name}", **@options}
    end
  end
end
