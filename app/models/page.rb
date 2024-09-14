class Page < ApplicationRecord
  include WithTime
  include WithAttachment
  include WithEditor

  has_many :attachments, as: :attachable, dependent: :destroy
  belongs_to :bogue, optional: true

  scope :active, -> {where(status: 0)}

  enum :status, "Public" => 0, "Privé" => 1
end
