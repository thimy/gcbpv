require "test_helper"

class EcoleControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get ecole_index_url
    assert_response :success
  end
end
