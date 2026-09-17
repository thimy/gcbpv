# == Schema Information
#
# Table name: events
#
#  id              :bigint           not null, primary key
#  city            :string
#  comment         :text
#  content         :jsonb
#  cover           :string
#  description     :text
#  end_date        :datetime
#  end_time        :time
#  event_type      :integer
#  highlight       :boolean
#  is_emt          :boolean
#  location        :text
#  name            :string
#  organizer       :string
#  slug            :string
#  start_date      :datetime
#  start_time      :time
#  status          :integer
#  website         :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  bogue_id        :bigint
#  parent_event_id :bigint
#
# Indexes
#
#  index_events_on_bogue_id         (bogue_id)
#  index_events_on_parent_event_id  (parent_event_id)
#
FactoryBot.define do
  factory :event do
    name { "MyString" }
    description { "MyText" }
    location { "MyText" }
    city { "MyString" }
    start_date { "2024-05-01 16:45:49" }
    end_date { "2024-05-01 16:45:49" }
  end
end
