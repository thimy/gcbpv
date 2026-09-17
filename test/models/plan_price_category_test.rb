require "test_helper"

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
class PlanPriceCategoryTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
