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
    name: Field::String,
    class_price: Field::Number.with_options(suffix: "€"),
    class_price_obc: Field::Number.with_options(suffix: "€"),
    class_price_outbounds: Field::Number.with_options(suffix: "€"),
    kids_class_price: Field::Number.with_options(suffix: "€"),
    kids_class_price_obc: Field::Number.with_options(suffix: "€"),
    kids_class_price_outbounds: Field::Number.with_options(suffix: "€"),
    workshop_price: Field::Number.with_options(suffix: "€"),
    workshop_price_obc: Field::Number.with_options(suffix: "€"),
    workshop_price_outbounds: Field::Number.with_options(suffix: "€"),
    early_learning_price: Field::Number.with_options(suffix: "€"),
    early_learning_price_obc: Field::Number.with_options(suffix: "€"),
    early_learning_price_outbounds: Field::Number.with_options(suffix: "€"),
    kid_discovery_price: Field::Number.with_options(suffix: "€"),
    kid_discovery_price_obc: Field::Number.with_options(suffix: "€"),
    kid_discovery_price_outbounds: Field::Number.with_options(suffix: "€"),
    first_step: Field::Number.with_options(suffix: "€"),
    first_step_discount: Field::Number.with_options(suffix: "%"),
    second_step: Field::Number.with_options(suffix: "€"),
    second_step_discount: Field::Number.with_options(suffix: "%"),
    third_step: Field::Number.with_options(suffix: "€"),
    third_step_discount: Field::Number.with_options(suffix: "%"),
    obc_markup: Field::Number.with_options(suffix: "%"),
    outbounds_markup: Field::Number.with_options(suffix: "%"),
    membership_price: Field::Number.with_options(suffix: "€"),
    comment: Field::Text,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    price_categories: Field::NestedHasMany.with_options(skip: :plan),
    plan_price_categories: Field::NestedHasMany.with_options(skip: :plan),
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = %i[
    id
    name
    membership_price
    kids_class_price
    class_price
    workshop_price
    obc_markup
    outbounds_markup
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = %i[
    id
    name
    membership_price
    class_price
    kids_class_price
    workshop_price
    early_learning_price
    kid_discovery_price
    first_step
    first_step_discount
    second_step
    second_step_discount
    third_step
    third_step_discount
    obc_markup
    outbounds_markup
    comment
    plan_price_categories
    created_at
    updated_at
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = %i[
    name
    membership_price
    class_price
    class_price_obc
    class_price_outbounds
    kids_class_price
    kids_class_price_obc
    kids_class_price_outbounds
    workshop_price
    workshop_price_obc
    workshop_price_outbounds
    first_step
    first_step_discount
    second_step
    second_step_discount
    third_step
    third_step_discount
    obc_markup
    outbounds_markup
    plan_price_categories
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
