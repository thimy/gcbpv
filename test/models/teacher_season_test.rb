require "test_helper"

# == Schema Information
#
# Table name: teacher_seasons
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  season_id  :bigint           not null
#  teacher_id :bigint           not null
#
# Indexes
#
#  index_teacher_seasons_on_season_id   (season_id)
#  index_teacher_seasons_on_teacher_id  (teacher_id)
#
# Foreign Keys
#
#  fk_rails_...  (season_id => seasons.id)
#  fk_rails_...  (teacher_id => teachers.id)
#
class TeacherSeasonTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
