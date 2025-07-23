class Plan < ApplicationRecord
  has_many :plan_price_categories
  has_many :price_categories, through: :plan_price_categories
  accepts_nested_attributes_for :plan_price_categories
end
