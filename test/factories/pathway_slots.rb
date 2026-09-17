# == Schema Information
#
# Table name: pathway_slots
#
#  id          :bigint           not null, primary key
#  comment     :text
#  day_of_week :integer
#  status      :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  city_id     :bigint           not null
#  pathway_id  :bigint           not null
#
# Indexes
#
#  index_pathway_slots_on_city_id     (city_id)
#  index_pathway_slots_on_pathway_id  (pathway_id)
#
# Foreign Keys
#
#  fk_rails_...  (city_id => cities.id)
#  fk_rails_...  (pathway_id => pathways.id)
#
FactoryBot.define do
  factory :pathway_slot do
    pathway { nil }
    city { nil }
    day_of_week { 1 }
  end
end
