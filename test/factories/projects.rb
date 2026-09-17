# == Schema Information
#
# Table name: projects
#
#  id         :bigint           not null, primary key
#  comment    :text
#  content    :text
#  name       :string
#  status     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  season_id  :bigint
#
# Indexes
#
#  index_projects_on_season_id  (season_id)
#
FactoryBot.define do
  factory :project do
    name { "MyString" }
    description { "MyText" }
    season { nil }
    status { "MyString" }
  end
end
