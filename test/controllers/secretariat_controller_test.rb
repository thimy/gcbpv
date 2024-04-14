require "test_helper"

class SecretariatControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get secretariat_index_url
    assert_response :success
  end
end
