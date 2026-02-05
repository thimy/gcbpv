require "test_helper"

class BogueTest < ActiveSupport::TestCase
  test "should save with a name" do
    bogue = Bogue.new(start_date: Datetime.new(2025, 10, 27), end_date: Datetime.new(2025, 10, 31), slug: "bogue-2025")
    assert_not bogue.save, "Bogue has no name"
  end
  test "should save with a start date" do
    bogue = Bogue.new(name: "Bogue 2025", end_date: Datetime.new(2025, 10, 31), slug: "bogue-2025")
    assert_not bogue.save, "Bogue has no start date"
  end
  test "should save with a start date" do
    bogue = Bogue.new(name: "Bogue 2025", start_date: Datetime.new(2025, 10, 27), slug: "bogue-2025")
    assert_not bogue.save, "Bogue has no end date"
  end
  test "should save with a start date" do
    bogue = Bogue.new(name: "Bogue 2025", start_date: Datetime.new(2025, 10, 27), end_date: Datetime.new(2025, 10, 31))
    assert_not bogue.save, "Bogue has no slug"
  end
end
