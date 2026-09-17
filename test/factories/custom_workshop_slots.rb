# == Schema Information
#
# Table name: workshop_slots
#
#  id          :bigint           not null, primary key
#  comment     :text
#  day_of_week :integer
#  frequency   :integer
#  is_custom   :boolean
#  slot_time   :string
#  status      :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  city_id     :bigint           not null
#  workshop_id :bigint           not null
#
# Indexes
#
#  index_workshop_slots_on_city_id      (city_id)
#  index_workshop_slots_on_workshop_id  (workshop_id)
#
# Foreign Keys
#
#  fk_rails_...  (city_id => cities.id)
#  fk_rails_...  (workshop_id => workshops.id)
#
FactoryBot.define do
  factory :custom_workshop_slot do
    
  end
end
