require "test_helper"

class Ecole::TrainingsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get ecole_trainings_index_url
    assert_response :success
  end

  test "should get show" do
    get ecole_trainings_show_url
    assert_response :success
  end
end
