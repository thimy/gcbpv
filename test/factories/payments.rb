# == Schema Information
#
# Table name: payments
#
#  id                    :bigint           not null, primary key
#  amount                :decimal(, )
#  comment               :text
#  date                  :datetime
#  payment_method        :integer
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  subscription_group_id :bigint           not null
#
# Indexes
#
#  index_payments_on_subscription_group_id  (subscription_group_id)
#
# Foreign Keys
#
#  fk_rails_...  (subscription_group_id => subscription_groups.id)
#
FactoryBot.define do
  factory :payment do
    payment_method { 1 }
    amount { "9.99" }
    SubscriptionGroup { nil }
    comment { "MyText" }
  end
end
