require "administrate/base_dashboard"

class SlotDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    id: Field::Number,
    teacher: Field::BelongsToSearch.with_options(
      class: "Teacher",
      searchable: true
    ),
    city: Field::BelongsToSearch.with_options(class: "City"),
    day: Field::Select.with_options(collection: DayOfWeek::DAYS_OF_WEEK),
    start_time: Field::Time.with_options(format: "%H:%M"),
    end_time: Field::Time.with_options(format: "%H:%M"),
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = %i[
    teacher
    city
    day
    start_time
    end_time
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = %i[
    teacher
    city
    day
    start_time
    end_time
    created_at
    updated_at
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = %i[
    teacher
    city
    day
    start_time
    end_time
  ].freeze

  # COLLECTION_FILTERS
  # a hash that defines filters that can be used while searching via the search
  # field of the dashboard.
  #
  # For example to add an option to search for open resources by typing "open:"
  # in the search field:
  #
  #   COLLECTION_FILTERS = {
  #     open: ->(resources) { resources.where(open: true) }
  #   }.freeze
  COLLECTION_FILTERS = {}.freeze

  # Overwrite this method to customize how availabilities are displayed
  # across all pages of the admin dashboard.
  #
  def display_resource(slot)
    slot.name
  end
end
