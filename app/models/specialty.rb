# == Schema Information
#
# Table name: specialties
#
#  id            :bigint           not null, primary key
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  instrument_id :bigint           not null
#  teacher_id    :bigint           not null
#
# Indexes
#
#  index_specialties_on_instrument_id  (instrument_id)
#  index_specialties_on_teacher_id     (teacher_id)
#
# Foreign Keys
#
#  fk_rails_...  (instrument_id => instruments.id)
#  fk_rails_...  (teacher_id => teachers.id)
#
class Specialty < ApplicationRecord
  belongs_to :instrument
  belongs_to :teacher
end
