require "administrate/base_dashboard"

class SubscriptionDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    id: Field::Number,
    courses: Field::NestedHasMany.with_options(skip: :subscription),
    pathway_slots: Field::HasMany,
    subbed_workshops: Field::NestedHasMany.with_options(skip: :subscription),
    kid_workshop_slot: Field::BelongsTo,
    student: Field::BelongsTo,
    image_consent: Field::Boolean,
    disability: Field::Boolean,
    ars: Field::Boolean,
    course_list: Field::String.with_options(searchable: false),
    workshop_list: Field::String.with_options(searchable: false),
    phone: Field::String.with_options(searchable: false),
    email: Field::String.with_options(searchable: false),
    city: Field::String.with_options(searchable: false),
    comment: Field::Text,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = %i[
    student
    course_list
    workshop_list
    phone
    email
    city
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = %i[
    student
    courses
    subbed_workshops
    kid_workshop_slot
    image_consent
    disability
    ars
    comment
    created_at
    updated_at
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = %i[
    student
    courses
    subbed_workshops
    kid_workshop_slot
    image_consent
    disability
    ars
    comment
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

  # Overwrite this method to customize how subscriptions are displayed
  # across all pages of the admin dashboard.
  #
  def display_resource(subscription)
    subscription.student.name
  end
end
