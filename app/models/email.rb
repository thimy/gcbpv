# == Schema Information
#
# Table name: emails
#
#  id         :bigint           not null, primary key
#  body       :text
#  recipients :string
#  status     :integer
#  subject    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Email < ApplicationRecord
  include EmailImagesHandler
  include WithAttachment
  include WithEditor
  has_many :email_images, dependent: :destroy
  has_many :attachments, as: :attachable, dependent: :destroy
  
  validates :subject, presence: true
  validates :recipients, presence: true
  validates :body, presence: true
  validates :status, presence: true
end
