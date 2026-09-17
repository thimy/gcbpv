# == Schema Information
#
# Table name: projects
#
#  id         :bigint           not null, primary key
#  comment    :text
#  content    :text
#  name       :string
#  status     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  season_id  :bigint
#
# Indexes
#
#  index_projects_on_season_id  (season_id)
#
class Project < ApplicationRecord
  include WithEditor

  has_many :project_students
  has_many :students, through: :project_students
  belongs_to :season

  validates :name, presence: true
  validates :status, presence: true

  enum :status, "Public" => 0, "Privé" => 1

  scope :visible, -> {where(status: 0)}
end
