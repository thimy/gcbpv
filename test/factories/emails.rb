# == Schema Information
#
# Table name: emails
#
#  id         :bigint           not null, primary key
#  body       :text
#  recipients :string
#  status     :integer
#  subject    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :email do
    subject { "MyString" }
    recipients { "MyString" }
    body { "MyText" }
    status { 1 }
  end
end
