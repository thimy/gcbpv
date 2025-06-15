require "administrate/base_dashboard"

class PlanDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    id: Field::Number,
    class_price: Field::Number.with_options(suffix: "€"),
    kids_class_price: Field::Number.with_options(suffix: "€"),
    workshop_price: Field::Number.with_options(suffix: "€"),
    early_learning_price: Field::Number.with_options(suffix: "€"),
    kid_discovery_price: Field::Number.with_options(suffix: "€"),
    first_step: Field::Number.with_options(suffix: "€"),
    first_step_discount: Field::Number.with_options(suffix: "%"),
    second_step: Field::Number.with_options(suffix: "€"),
    second_step_discount: Field::Number.with_options(suffix: "%"),
    third_step: Field::Number.with_options(suffix: "€"),
    third_step_discount: Field::Number.with_options(suffix: "%"),
    obc_markup: Field::Number.with_options(suffix: "%"),
    outbounds_markup: Field::Number.with_options(suffix: "%"),
    membership_price: Field::Number.with_options(suffix: "€"),
    special_workshop_price: Field::Number.with_options(suffix: "€"),
    pathway_price: Field::Number.with_options(suffix: "€"),
    family_pathway_price: Field::Number.with_options(suffix: "€"),
    standalone_workshop_price: Field::Number.with_options(suffix: "€"),
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
    id
    membership_price
    kids_class_price
    class_price
    workshop_price
    special_workshop_price
    standalone_workshop_price
    obc_markup
    outbounds_markup
    pathway_price
    family_pathway_price
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = %i[
    id
    membership_price
    class_price
    kids_class_price
    workshop_price
    special_workshop_price
    standalone_workshop_price
    early_learning_price
    kid_discovery_price
    pathway_price
    family_pathway_price
    first_step
    first_step_discount
    second_step
    second_step_discount
    third_step
    third_step_discount
    obc_markup
    outbounds_markup
    comment
    created_at
    updated_at
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = %i[
    membership_price
    class_price
    kids_class_price
    workshop_price
    special_workshop_price
    standalone_workshop_price
    early_learning_price
    kid_discovery_price
    pathway_price
    family_pathway_price
    first_step
    first_step_discount
    second_step
    second_step_discount
    third_step
    third_step_discount
    obc_markup
    outbounds_markup
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

  # Overwrite this method to customize how plans are displayed
  # across all pages of the admin dashboard.
  #
  def display_resource(plan)
    plan.name
  end
end
