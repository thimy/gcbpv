class PostDecorator < ApplicationDecorator
  delegate_all
  filter_attributes :created_at,
                    :published_at,
                    :with => :strftime("%d/%m/%Y")

  def cover_image
    return cover if cover.present?

    if categories.present?
      categories.each do |category|
        if category.id != 0
          return get_cover(category)
        end
      end
      get_cover(Category.find(0))
    end
  end

  private

  def get_cover(category)
    covers = [category[:cover1], category[:cover2], category[:cover3]].compact
    return covers[rand(covers.size - 1)]
  end
end
