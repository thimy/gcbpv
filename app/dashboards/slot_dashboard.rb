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
    city: Field::BelongsTo,
    day_of_week: Field::Select.with_options(collection: -> (field) { field.resource.class.send(field.attribute.to_s.pluralize).keys }),
    frequency: Field::Select.with_options(collection: -> (field) { field.resource.class.send(field.attribute.to_s.pluralize).keys }),
    slot_time: Field::String,
    teacher: Field::BelongsTo.with_options(scope: -> { Teacher.where(status: 0) }),
    status: Field::Select.with_options(searchable: false, collection: ->(field) { field.resource.class.send(field.attribute.to_s.pluralize).keys }),
    comment: Field::Text,
    student_count: Field::Text.with_options(searchable: false),
    courses: SubscriptionListField,
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
    day_of_week
    slot_time
    student_count
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = %i[
    teacher
    city
    courses
    day_of_week
    frequency
    slot_time
    comment
    status
    updated_at
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = %i[
    teacher
    city
    day_of_week
    slot_time
    comment
    frequency
    status
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

  # Overwrite this method to customize how slots are displayed
  # across all pages of the admin dashboard.
  #
  def display_resource(slot)
    slot.name
  end
end
