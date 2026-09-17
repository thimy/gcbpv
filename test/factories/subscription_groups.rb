# == Schema Information
#
# Table name: subscription_groups
#
#  id               :bigint           not null, primary key
#  amount           :decimal(, )
#  amount_paid      :decimal(, )
#  comment          :text
#  discount         :decimal(, )
#  donation         :decimal(, )
#  majoration_class :integer
#  status           :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  household_id     :bigint
#  season_id        :bigint           not null
#
# Indexes
#
#  index_subscription_groups_on_household_id  (household_id)
#  index_subscription_groups_on_season_id     (season_id)
#
# Foreign Keys
#
#  fk_rails_...  (season_id => seasons.id)
#
FactoryBot.define do
  factory :subscription_group do
    amount_paid { "9.99" }
    comment { "MyText" }
    household { nil }
  end
end
