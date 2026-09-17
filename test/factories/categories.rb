# == Schema Information
#
# Table name: categories
#
#  id         :bigint           not null, primary key
#  cover1     :string
#  cover2     :string
#  cover3     :string
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :category do
    name { "MyString" }
  end
end
