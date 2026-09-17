# == Schema Information
#
# Table name: workshops
#
#  id                :bigint           not null, primary key
#  comment           :text
#  description       :string
#  is_full           :boolean
#  is_youth          :boolean
#  kid_friendly      :boolean
#  kid_workshop_type :integer
#  max_students      :integer
#  name              :string
#  status            :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  price_category_id :bigint
#
# Indexes
#
#  index_workshops_on_price_category_id  (price_category_id)
#
FactoryBot.define do
  factory :kid_workshop do
    name { "MyString" }
    frequency { "MyString" }
    description { "MyText" }
    plan { nil }
  end
end
