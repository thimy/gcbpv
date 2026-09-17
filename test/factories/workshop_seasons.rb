# == Schema Information
#
# Table name: workshop_seasons
#
#  id          :bigint           not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  season_id   :bigint           not null
#  workshop_id :bigint           not null
#
# Indexes
#
#  index_workshop_seasons_on_season_id    (season_id)
#  index_workshop_seasons_on_workshop_id  (workshop_id)
#
# Foreign Keys
#
#  fk_rails_...  (season_id => seasons.id)
#  fk_rails_...  (workshop_id => workshops.id)
#
FactoryBot.define do
  factory :workshop_season do
    season { nil }
    workshop { nil }
  end
end
