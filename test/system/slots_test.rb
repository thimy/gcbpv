require "application_system_test_case"

class SlotsTest < ApplicationSystemTestCase
  setup do
    @slot = slots(:one)
  end

  test "visiting the index" do
    visit slots_url
    assert_selector "h1", text: "Slots"
  end

  test "should create slot" do
    visit slots_url
    click_on "New slot"

    fill_in "City", with: @slot.city_id
    fill_in "Day of week", with: @slot.day_of_week
    fill_in "End time", with: @slot.end_time
    fill_in "Frequency", with: @slot.frequency
    fill_in "Start time", with: @slot.start_time
    fill_in "Teacher", with: @slot.teacher_id
    click_on "Create Slot"

    assert_text "Slot was successfully created"
    click_on "Back"
  end

  test "should update Slot" do
    visit slot_url(@slot)
    click_on "Edit this slot", match: :first

    fill_in "City", with: @slot.city_id
    fill_in "Day of week", with: @slot.day_of_week
    fill_in "End time", with: @slot.end_time
    fill_in "Frequency", with: @slot.frequency
    fill_in "Start time", with: @slot.start_time
    fill_in "Teacher", with: @slot.teacher_id
    click_on "Update Slot"

    assert_text "Slot was successfully updated"
    click_on "Back"
  end

  test "should destroy Slot" do
    visit slot_url(@slot)
    click_on "Destroy this slot", match: :first

    assert_text "Slot was successfully destroyed"
  end
end
