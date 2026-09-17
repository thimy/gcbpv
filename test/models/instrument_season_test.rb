require "test_helper"

# == Schema Information
#
# Table name: instrument_seasons
#
#  id            :bigint           not null, primary key
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  instrument_id :bigint           not null
#  season_id     :bigint           not null
#
# Indexes
#
#  index_instrument_seasons_on_instrument_id  (instrument_id)
#  index_instrument_seasons_on_season_id      (season_id)
#
# Foreign Keys
#
#  fk_rails_...  (instrument_id => instruments.id)
#  fk_rails_...  (season_id => seasons.id)
#
class InstrumentSeasonTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
