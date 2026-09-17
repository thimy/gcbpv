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
class Training < ApplicationRecord
  include WithAttachment
  include WithEditor

  has_many :training_sessions
  has_many :attachments, as: :attachable, dependent: :destroy
  belongs_to :season

  accepts_nested_attributes_for :training_sessions

  validates :name, presence: true
  validates :price, presence: true
  validates :season, presence: true

  scope :visible, -> {where(status: 0)}
  scope :active, ->(season) { where(season: season) }
  
  enum :status, "Public" => 0, "Privé" => 1
end
