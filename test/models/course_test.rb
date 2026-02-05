require "test_helper"

class CourseTest < ActiveSupport::TestCase
  test "should have a slot" do
    course = Course.new(instrument: instrument[:one], subscription: subscription[:one], frequency: 0)
    assert_not course.save("Course doesn't have a slot")
  end
  test "should have an instrument" do
    course = Course.new(slot: slots[:one], subscription: subscription[:one], frequency: 0)
    assert_not course.save("Course doesn't have an instrument")
  end
  test "should have a subscription" do
    course = Course.new(slot: slots[:one], instrument: instrument[:one], frequency: 0)
    assert_not course.save("Course doesn't have a subscription")
  end
  test "should have a frequency" do
    course = Course.new(slot: slots[:one], instrument: instrument[:one], subscription: subscription[:one])
    assert_not course.save("Course doesn't have a frequency")
  end
end
