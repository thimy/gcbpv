require "test_helper"

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
class PostTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
