require "test_helper"

class Archives::EditionsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get archives_editions_index_url
    assert_response :success
  end

  test "should get show" do
    get archives_editions_show_url
    assert_response :success
  end
end
