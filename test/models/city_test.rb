require "test_helper"

# == Schema Information
#
# Table name: cities
#
#  id               :bigint           not null, primary key
#  comment          :text
#  name             :string
#  postcode         :string
#  status           :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  agglomeration_id :bigint
#
# Indexes
#
#  index_cities_on_agglomeration_id  (agglomeration_id)
#
class CityTest < ActiveSupport::TestCase
  test "should have a name" do
    city = City.new(postcode: "35600", status: 0)
    assert_not city.save, "City has no name"
  end
  test "should have a name" do
    city = City.new(name: "Redon", status: 0)
    assert_not city.save, "City has no postcode"
  end
  test "should have a name" do
    city = City.new(name: "Redon", postcode: "35600")
    assert_not city.save, "City has no status"
  end
end
