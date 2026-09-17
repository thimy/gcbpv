# == Schema Information
#
# Table name: training_sessions
#
#  id          :bigint           not null, primary key
#  city        :string
#  comment     :text
#  content     :text
#  date        :date
#  end_time    :string
#  guest       :string
#  image       :text
#  location    :string
#  name        :string
#  price       :decimal(, )
#  start_time  :string
#  status      :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  training_id :bigint           not null
#
# Indexes
#
#  index_training_sessions_on_training_id  (training_id)
#
# Foreign Keys
#
#  fk_rails_...  (training_id => trainings.id)
#
FactoryBot.define do
  factory :training_session do
    name { "MyString" }
    description { "MyText" }
    training { nil }
    date { "2024-05-10" }
    start_time { "MyText" }
    end_time { "MyText" }
  end
end
