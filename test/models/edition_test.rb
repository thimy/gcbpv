require "test_helper"

# == Schema Information
#
# Table name: editions
#
#  id          :bigint           not null, primary key
#  comment     :text
#  description :text
#  format      :string
#  image       :string
#  name        :string
#  price       :decimal(, )
#  status      :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class EditionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
