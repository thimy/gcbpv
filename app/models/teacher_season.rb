class TeacherSeason < ApplicationRecord
  belongs_to :season
  belongs_to :teacher
end
