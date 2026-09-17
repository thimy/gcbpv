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
class Loan < ApplicationRecord
  belongs_to :subscription
end
