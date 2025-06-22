# frozen_string_literal: true

class Shared::Table::Footer::Component < ViewComponent::Base
  renders_many :cells, "CellComponent"

  def initialize(**options)
    @options = options || {}
  end

  def row_options
    if @link_url.present?
      @options[:action] = "click->linkable#navigate",
      @options["linkable-path-param"] = @link_url
    end
    
    @options
  end

  class CellComponent < ViewComponent::Base
    def initialize(name:, id: nil, **options)
      @name = name
      @id = id
      @options = options || {}
    end

    def call
      content_tag "th", content, {class: "cell-#{@name}", **@options}
    end
  end
end
