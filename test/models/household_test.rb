require "test_helper"

# == Schema Information
#
# Table name: households
#
#  id                   :bigint           not null, primary key
#  address              :string
#  city                 :string
#  comment              :text
#  email                :string
#  first_name           :string
#  last_name            :string
#  phone                :string
#  postcode             :string
#  secondary_email      :string
#  secondary_first_name :string
#  secondary_last_name  :string
#  secondary_phone      :string
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#
class HouseholdTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
