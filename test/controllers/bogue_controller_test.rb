require "test_helper"

class BogueControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get bogue_index_url
    assert_response :success
  end

  test "should get show" do
    get bogue_show_url
    assert_response :success
  end
end
