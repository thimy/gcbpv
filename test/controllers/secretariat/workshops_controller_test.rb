require "test_helper"

class WorkshopsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @workshop = workshops(:one)
  end

  test "should get index" do
    get workshops_url
    assert_response :success
  end

  test "should get new" do
    get new_workshop_url
    assert_response :success
  end

  test "should create workshop" do
    assert_difference("Workshop.count") do
      post workshops_url, params: { workshop: { city_id: @workshop.city_id, day_of_week: @workshop.day_of_week, description: @workshop.description, end_time: @workshop.end_time, frequency: @workshop.frequency, name: @workshop.name, start_time: @workshop.start_time } }
    end

    assert_redirected_to workshop_url(Workshop.last)
  end

  test "should show workshop" do
    get workshop_url(@workshop)
    assert_response :success
  end

  test "should get edit" do
    get edit_workshop_url(@workshop)
    assert_response :success
  end

  test "should update workshop" do
    patch workshop_url(@workshop), params: { workshop: { city_id: @workshop.city_id, day_of_week: @workshop.day_of_week, description: @workshop.description, end_time: @workshop.end_time, frequency: @workshop.frequency, name: @workshop.name, start_time: @workshop.start_time } }
    assert_redirected_to workshop_url(@workshop)
  end

  test "should destroy workshop" do
    assert_difference("Workshop.count", -1) do
      delete workshop_url(@workshop)
    end

    assert_redirected_to workshops_url
  end
end
