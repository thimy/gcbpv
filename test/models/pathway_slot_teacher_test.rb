require "test_helper"

# == Schema Information
#
# Table name: pathway_slot_teachers
#
#  id              :bigint           not null, primary key
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  pathway_slot_id :bigint
#  teacher_id      :bigint           not null
#
# Indexes
#
#  index_pathway_slot_teachers_on_pathway_slot_id  (pathway_slot_id)
#  index_pathway_slot_teachers_on_teacher_id       (teacher_id)
#
# Foreign Keys
#
#  fk_rails_...  (teacher_id => teachers.id)
#
class PathwaySlotTeacherTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
