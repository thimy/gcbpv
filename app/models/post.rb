# == Schema Information
#
# Table name: posts
#
#  id           :bigint           not null, primary key
#  content      :jsonb
#  cover        :string
#  published_at :datetime
#  sent_at      :datetime
#  status       :integer
#  title        :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  event_id     :bigint
#
# Indexes
#
#  index_posts_on_event_id  (event_id)
#
class Post < ApplicationRecord
  include WithTime
  include WithAttachment
  include WithEditor

  has_many :categories_posts
  has_many :categories, through: :categories_posts
  belongs_to :event, optional: true, required: false
  has_many :attachments, as: :attachable, dependent: :destroy

  validates :title, presence: true

  enum :status, "Privé": 0, "Public": 1
  scope :latest, -> { where(status: "Public").order(published_at: :desc) }
  scope :ordered, -> { order(created_at: :desc) }

  def publication_datetime
    format_datetime(published_at)
  end
end
