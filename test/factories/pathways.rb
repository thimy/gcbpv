# == Schema Information
#
# Table name: pathways
#
#  id          :bigint           not null, primary key
#  comment     :text
#  description :text
#  name        :string
#  status      :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
FactoryBot.define do
  factory :pathway do
    name { "MyString" }
    description { "MyText" }
  end
end
