require "test_helper"

# == Schema Information
#
# Table name: teachers
#
#  id          :bigint           not null, primary key
#  comment     :text
#  description :text
#  email       :string
#  first_name  :string
#  last_name   :string
#  phone       :string
#  photo       :string
#  status      :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class TeacherTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
