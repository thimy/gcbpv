require "test_helper"

class Ecole::ProjectsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get ecole_projects_index_url
    assert_response :success
  end

  test "should get show" do
    get ecole_projects_show_url
    assert_response :success
  end
end
