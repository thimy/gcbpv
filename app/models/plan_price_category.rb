class PlanPriceCategory < ApplicationRecord
  belongs_to :plan
  belongs_to :price_category
end
