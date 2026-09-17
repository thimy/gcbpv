require "test_helper"

# == Schema Information
#
# Table name: courses
#
#  id              :bigint           not null, primary key
#  comment         :text
#  end_time        :time
#  frequency       :integer
#  option          :integer
#  start_time      :time
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  instrument_id   :bigint           not null
#  slot_id         :bigint           not null
#  subscription_id :bigint
#
# Indexes
#
#  index_courses_on_instrument_id    (instrument_id)
#  index_courses_on_slot_id          (slot_id)
#  index_courses_on_subscription_id  (subscription_id)
#
# Foreign Keys
#
#  fk_rails_...  (instrument_id => instruments.id)
#  fk_rails_...  (slot_id => slots.id)
#
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
