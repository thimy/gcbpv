FactoryBot.define do
  factory :email do
    subject { "MyString" }
    recipients { "MyString" }
    body { "MyText" }
    status { 1 }
  end
end
