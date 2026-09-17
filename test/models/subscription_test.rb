require "test_helper"

# == Schema Information
#
# Table name: subscriptions
#
#  id                    :bigint           not null, primary key
#  ars                   :boolean
#  comment               :text
#  disability            :boolean
#  image_consent         :boolean
#  instrument_loan       :string
#  status                :integer
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  student_id            :bigint           not null
#  subscription_group_id :bigint
#
# Indexes
#
#  index_subscriptions_on_student_id             (student_id)
#  index_subscriptions_on_subscription_group_id  (subscription_group_id)
#
# Foreign Keys
#
#  fk_rails_...  (student_id => students.id)
#
class SubscriptionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
