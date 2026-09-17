# == Schema Information
#
# Table name: pages
#
#  id         :bigint           not null, primary key
#  city       :string
#  comment    :text
#  content    :jsonb
#  end_date   :datetime
#  location   :string
#  name       :string
#  slug       :string
#  start_date :datetime
#  status     :integer
#  type       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  bogue_id   :bigint
#
# Indexes
#
#  index_pages_on_bogue_id  (bogue_id)
#
class Page < ApplicationRecord
  include WithTime
  include WithAttachment
  include WithEditor

  has_many :attachments, as: :attachable, dependent: :destroy
  belongs_to :bogue, optional: true

  validates :name, presence: true
  validates :content, presence: true
  validates :slug, presence: true

  scope :active, -> {where(status: 0)}

  enum :status, "Public" => 0, "Privé" => 1
end
