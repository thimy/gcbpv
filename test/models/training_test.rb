require "test_helper"

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
class TrainingTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
