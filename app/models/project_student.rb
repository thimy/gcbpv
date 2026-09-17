# == Schema Information
#
# Table name: project_students
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  project_id :bigint
#  student_id :bigint           not null
#
# Indexes
#
#  index_project_students_on_project_id  (project_id)
#  index_project_students_on_student_id  (student_id)
#
# Foreign Keys
#
#  fk_rails_...  (student_id => students.id)
#
class ProjectStudent < ApplicationRecord
  belongs_to :project
  belongs_to :student
end
