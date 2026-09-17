require "test_helper"

# == Schema Information
#
# Table name: slot_seasons
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  season_id  :bigint           not null
#  slot_id    :bigint           not null
#
# Indexes
#
#  index_slot_seasons_on_season_id  (season_id)
#  index_slot_seasons_on_slot_id    (slot_id)
#
# Foreign Keys
#
#  fk_rails_...  (season_id => seasons.id)
#  fk_rails_...  (slot_id => slots.id)
#
class SlotSeasonTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
