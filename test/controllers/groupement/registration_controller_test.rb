require "test_helper"

class Groupement::RegistrationControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get groupement_registration_index_url
    assert_response :success
  end

  test "should get show" do
    get groupement_registration_show_url
    assert_response :success
  end
end
