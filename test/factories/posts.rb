FactoryBot.define do
  factory :post do
    title { "MyString" }
    content { "MyText" }
    image { "MyString" }
    status { "MyString" }
    event { nil }
  end
end
