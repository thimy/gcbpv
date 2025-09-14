class Training < ApplicationRecord
  include WithAttachment
  include WithEditor

  has_many :training_sessions
  has_many :attachments, as: :attachable, dependent: :destroy
  belongs_to :season

  accepts_nested_attributes_for :training_sessions

  scope :visible, -> {where(status: 0)}
  scope :active, ->(season) { where(season: season) }
  
  enum :status, "Public" => 0, "Privé" => 1
end
