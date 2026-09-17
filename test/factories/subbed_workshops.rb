# == Schema Information
#
# Table name: subbed_workshops
#
#  id               :bigint           not null, primary key
#  comment          :text
#  option           :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  subscription_id  :bigint           not null
#  workshop_slot_id :bigint
#
# Indexes
#
#  index_subbed_workshops_on_subscription_id   (subscription_id)
#  index_subbed_workshops_on_workshop_slot_id  (workshop_slot_id)
#
# Foreign Keys
#
#  fk_rails_...  (subscription_id => subscriptions.id)
#
FactoryBot.define do
  factory :subbed_workshop do
    workshop { nil }
    subscription { nil }
    comment { "MyText" }
  end
end
