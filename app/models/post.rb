class Post < ApplicationRecord
  include WithTime
  include WithAttachment
  include WithEditor

  has_and_belongs_to_many :categories
  belongs_to :event, optional: true, required: false
  has_one_attached :image
  has_many :attachments, as: :attachable, dependent: :destroy

  enum :status, "Privé": 0, "Public": 1
  scope :latest, -> { where(status: "Public").order(published_at: :desc) }

  def publication_datetime
    format_datetime(published_at)
  end
end
