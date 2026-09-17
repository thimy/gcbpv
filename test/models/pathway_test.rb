require "test_helper"

# == Schema Information
#
# Table name: pathways
#
#  id          :bigint           not null, primary key
#  comment     :text
#  description :text
#  name        :string
#  status      :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class PathwayTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
