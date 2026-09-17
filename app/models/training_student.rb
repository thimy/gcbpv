# == Schema Information
#
# Table name: training_students
#
#  id                  :bigint           not null, primary key
#  student_id          :bigint           not null
#  training_session_id :bigint           not null
#
# Indexes
#
#  index_training_students_on_student_id           (student_id)
#  index_training_students_on_training_session_id  (training_session_id)
#
# Foreign Keys
#
#  fk_rails_...  (student_id => students.id)
#  fk_rails_...  (training_session_id => training_sessions.id)
#
class TrainingStudent < ApplicationRecord
  belongs_to :training_session
  belongs_to :student
end
