# == Schema Information
#
# Table name: trainings
#
#  id            :bigint           not null, primary key
#  comment       :text
#  content       :text
#  name          :string
#  price         :decimal(, )
#  session_count :integer
#  status        :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  season_id     :bigint           not null
#
# Indexes
#
#  index_trainings_on_season_id  (season_id)
#
# Foreign Keys
#
#  fk_rails_...  (season_id => seasons.id)
#
FactoryBot.define do
  factory :training do
    name { "MyString" }
    description { "MyText" }
    instrument { "MyText" }
    session_count { 1 }
    price { "9.99" }
  end
end
