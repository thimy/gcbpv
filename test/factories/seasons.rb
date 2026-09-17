# == Schema Information
#
# Table name: seasons
#
#  id         :bigint           not null, primary key
#  start_year :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  plan_id    :bigint           not null
#
# Indexes
#
#  index_seasons_on_plan_id  (plan_id)
#
# Foreign Keys
#
#  fk_rails_...  (plan_id => plans.id)
#
FactoryBot.define do
  factory :season do
    start_year { 1 }
    plan { nil }
  end
end
