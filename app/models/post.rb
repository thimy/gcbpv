class Post < ApplicationRecord
  include WithTime
  include WithAttachment
  include WithEditor

  has_many :categories_posts
  has_many :categories, through: :categories_posts
  belongs_to :event, optional: true, required: false
  has_one_attached :image
  has_many :attachments, as: :attachable, dependent: :destroy

  validates :title, presence: true

  enum :status, "Privé": 0, "Public": 1
  scope :latest, -> { where(status: "Public").order(published_at: :desc) }
  scope :ordered, -> { order(published_at: :desc) }

  def publication_datetime
    format_datetime(published_at)
  end
end
