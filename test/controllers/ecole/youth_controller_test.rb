require "test_helper"

class Ecole::YouthControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get ecole_youth_index_url
    assert_response :success
  end

  test "should get show" do
    get ecole_youth_show_url
    assert_response :success
  end
end
