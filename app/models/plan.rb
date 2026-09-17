# == Schema Information
#
# Table name: plans
#
#  id                                         :bigint           not null, primary key
#  class_double_workshop_price                :decimal(, )
#  class_double_workshop_price_obc            :decimal(, )
#  class_double_workshop_price_outbounds      :decimal(, )
#  class_price                                :decimal(, )
#  class_price_obc                            :decimal(, )
#  class_price_outbounds                      :decimal(, )
#  comment                                    :text
#  double_workshop_price                      :decimal(, )
#  double_workshop_price_obc                  :decimal(, )
#  double_workshop_price_outbounds            :decimal(, )
#  early_learning_price                       :decimal(, )
#  early_learning_price_obc                   :decimal(, )
#  early_learning_price_outbounds             :decimal(, )
#  first_step                                 :decimal(, )
#  first_step_discount                        :decimal(, )
#  kid_discovery_price                        :decimal(, )
#  kid_discovery_price_obc                    :decimal(, )
#  kid_discovery_price_outbounds              :decimal(, )
#  kid_double_workshop_price                  :decimal(, )
#  kid_double_workshop_price_obc              :decimal(, )
#  kid_double_workshop_price_outbounds        :decimal(, )
#  kid_workshop_price                         :decimal(, )
#  kid_workshop_price_obc                     :decimal(, )
#  kid_workshop_price_outbounds               :decimal(, )
#  kids_class_double_workshop_price           :decimal(, )
#  kids_class_double_workshop_price_obc       :decimal(, )
#  kids_class_double_workshop_price_outbounds :decimal(, )
#  kids_class_price                           :decimal(, )
#  kids_class_price_obc                       :decimal(, )
#  kids_class_price_outbounds                 :decimal(, )
#  membership_price                           :integer
#  name                                       :string
#  obc_markup                                 :integer
#  outbounds_markup                           :integer
#  second_step                                :decimal(, )
#  second_step_discount                       :decimal(, )
#  third_step                                 :decimal(, )
#  third_step_discount                        :decimal(, )
#  workshop_price                             :decimal(, )
#  workshop_price_obc                         :decimal(, )
#  workshop_price_outbounds                   :decimal(, )
#  created_at                                 :datetime         not null
#  updated_at                                 :datetime         not null
#
class Plan < ApplicationRecord
  has_many :plan_price_categories
  has_many :price_categories, through: :plan_price_categories
  accepts_nested_attributes_for :plan_price_categories
  
  validates :name, presence: true
end
