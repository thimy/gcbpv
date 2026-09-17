require "test_helper"

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
class EmailImageTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
