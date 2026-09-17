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
FactoryBot.define do
  factory :attachment do
    attachable { nil }
  end
end
