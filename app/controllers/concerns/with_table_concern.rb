module WithTableConcern
  include Pagy::Backend

  MAX_PER_PAGE = 20

  private

  def set_sort_params
    @sort_direction =  params[:direction] ? params[:direction] : default_sort_direction
    @sort_attribute = if valid_sort_attribute?(params[:sort])
      params[:sort]
    else
      default_sort_attribute
    end
  end

  def default_sort_direction
    "asc"
  end

  def paginate_records(records)
    pagy(
      with_sort_params(records),
      items: MAX_PER_PAGE
    )
  end

  def with_sort_params(records)
    if @sort_attribute.present?
      records.order(@sort_attribute => @sort_direction)
    else
      records
    end
  end

  def set_tab_data
    set_sort_params
    set_records
  end
end
