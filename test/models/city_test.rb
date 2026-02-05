require "test_helper"

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
