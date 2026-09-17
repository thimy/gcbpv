# == Schema Information
#
# Table name: price_categories
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :price_category do
    name { "MyString" }
  end
end
