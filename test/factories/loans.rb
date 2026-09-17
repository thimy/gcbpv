# == Schema Information
#
# Table name: loans
#
#  id              :bigint           not null, primary key
#  comment         :text
#  cost            :decimal(, )
#  instrument      :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  subscription_id :bigint           not null
#
# Indexes
#
#  index_loans_on_subscription_id  (subscription_id)
#
# Foreign Keys
#
#  fk_rails_...  (subscription_id => subscriptions.id)
#
FactoryBot.define do
  factory :loan do
    instrument { "MyString" }
    subscription { nil }
    cost { "9.99" }
  end
end
