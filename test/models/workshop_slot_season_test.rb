require "test_helper"

# == Schema Information
#
# Table name: workshop_slot_seasons
#
#  id               :bigint           not null, primary key
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  season_id        :bigint           not null
#  workshop_slot_id :bigint           not null
#
# Indexes
#
#  index_workshop_slot_seasons_on_season_id         (season_id)
#  index_workshop_slot_seasons_on_workshop_slot_id  (workshop_slot_id)
#
# Foreign Keys
#
#  fk_rails_...  (season_id => seasons.id)
#  fk_rails_...  (workshop_slot_id => workshop_slots.id)
#
class WorkshopSlotSeasonTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
