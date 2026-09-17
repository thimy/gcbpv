# == Schema Information
#
# Table name: plan_price_categories
#
#  id                :bigint           not null, primary key
#  obc_price         :decimal(, )
#  outbounds_price   :decimal(, )
#  price             :decimal(, )
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  plan_id           :bigint           not null
#  price_category_id :bigint           not null
#
# Indexes
#
#  index_plan_price_categories_on_plan_id            (plan_id)
#  index_plan_price_categories_on_price_category_id  (price_category_id)
#
# Foreign Keys
#
#  fk_rails_...  (plan_id => plans.id)
#  fk_rails_...  (price_category_id => price_categories.id)
#
FactoryBot.define do
  factory :plan_price_category do
    plan { nil }
    price_category { nil }
    price { "9.99" }
    obc_price { "9.99" }
    outbounds { "9.99" }
  end
end
