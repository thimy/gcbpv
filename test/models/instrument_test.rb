require "test_helper"

# == Schema Information
#
# Table name: instruments
#
#  id          :bigint           not null, primary key
#  comment     :text
#  description :text
#  image       :string
#  name        :string
#  status      :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class InstrumentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
