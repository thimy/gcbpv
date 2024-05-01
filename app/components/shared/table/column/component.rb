class Shared::Table::Column::Component < ViewComponent::Base
  delegate :inline_svg, to: :helpers

  def initialize(name:, show_label: true, sortable: false, sort_direction: nil, base_request_params: {}, **options)
    @name = name
    @show_label = show_label
    @sortable = sortable
    @sort_direction = sort_direction
    @options = options
    @base_request_params = base_request_params
  end

  def call
    tag.th class: css_classes, **@options do
      if @sortable
        link_to sortable_url do
          concat displayed_content
          concat inline_svg("icons/#{sorting_icon}")
        end
      else
        displayed_content
      end
    end
  end

  private

  def sortable_url
    url_for(@base_request_params.merge(sort: @name, direction: next_sort_direction))
  end

  def next_sort_direction
    if @sort_direction.blank? || @sort_direction == "desc"
      "asc"
    else
      "desc"
    end
  end

  def css_classes
    [
      "cell-#{@name}",
      ("sortable" if @sortable),
      ("sort-#{@sort_direction}" if @sort_direction)
    ].compact.join(" ")
  end

  def displayed_content
    return unless @show_label
    content.present? ? content : @name.humanize.titleize
  end

  def sorting_icon
    return "unsorted" unless @sort_direction
    (@sort_direction == "desc") ? "sort-desc" : "sort-asc"
  end
end
