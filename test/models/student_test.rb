require "test_helper"

# == Schema Information
#
# Table name: students
#
#  id         :bigint           not null, primary key
#  address    :string
#  birth_year :integer
#  city       :string
#  comment    :text
#  email      :string
#  first_name :string
#  gender     :integer
#  last_name  :string
#  phone      :string
#  postcode   :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class StudentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
