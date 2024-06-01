require "test_helper"

class AssociationControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get association_index_url
    assert_response :success
  end
end
