require "test_helper"

class Ecole::TeachersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get ecole_teachers_index_url
    assert_response :success
  end

  test "should get show" do
    get ecole_teachers_show_url
    assert_response :success
  end
end
