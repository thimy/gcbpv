# == Schema Information
#
# Table name: editions
#
#  id          :bigint           not null, primary key
#  comment     :text
#  description :text
#  format      :string
#  image       :string
#  name        :string
#  price       :decimal(, )
#  status      :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
FactoryBot.define do
  factory :edition do
    name { "MyString" }
    description { "MyText" }
    format { "MyString" }
    price { "9.99" }
    image { "MyString" }
  end
end
