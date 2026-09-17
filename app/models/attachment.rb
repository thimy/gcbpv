# == Schema Information
#
# Table name: attachments
#
#  id              :bigint           not null, primary key
#  attachable_type :string
#  extension       :string
#  name            :string
#  size            :float
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  attachable_id   :bigint
#
# Indexes
#
#  index_attachments_on_attachable  (attachable_type,attachable_id)
#
class Attachment < ApplicationRecord
  has_one_attached :file
  belongs_to :attachable, polymorphic: true, optional: true
end
