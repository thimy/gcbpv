# == Schema Information
#
# Table name: email_images
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  email_id   :bigint
#
# Indexes
#
#  index_email_images_on_email_id  (email_id)
#
# Foreign Keys
#
#  fk_rails_...  (email_id => emails.id)
#
class EmailImage < ApplicationRecord
  has_one_attached :image
  belongs_to :email, optional: true

  validates :email, presence: true
end
