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
class Payment < ApplicationRecord
  belongs_to :subscription_group

  validates :amount, presence: true
  validates :payment_method, presence: true
  validates :subscription_group_id, presence: true
  validates :date, presence: true

  enum :payment_method, "Espèces" => 0, "Chèque" => 1, "Virement" => 2, "Chèques Vacances" => 3, "Coupon Culture Sport Redon" => 4, "Forfait Passion CAF" => 5, "Chèques Vacances Connect" => 6

  def payment_date
    date || created_at
  end
end
