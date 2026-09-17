# == Schema Information
#
# Table name: bogues
#
#  id         :bigint           not null, primary key
#  comment    :text
#  content    :jsonb
#  end_date   :datetime
#  name       :string
#  slug       :string
#  start_date :datetime
#  status     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :bogue do
    name { "MyString" }
    content { "MyString" }
    location { "MyString" }
    city { "MyString" }
    start_date { "MyString" }
    end_date { "MyString" }
    status { "MyString" }
  end
end
