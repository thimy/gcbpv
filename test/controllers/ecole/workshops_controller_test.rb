require "test_helper"

class Ecole::WorkshopsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get ecole_workshops_index_url
    assert_response :success
  end

  test "should get show" do
    get ecole_workshops_show_url
    assert_response :success
  end
end
