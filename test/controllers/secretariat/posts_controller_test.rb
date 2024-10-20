require "test_helper"

class Secretariat::PostsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get secretariat_posts_index_url
    assert_response :success
  end

  test "should get new" do
    get secretariat_posts_new_url
    assert_response :success
  end

  test "should get show" do
    get secretariat_posts_show_url
    assert_response :success
  end

  test "should get create" do
    get secretariat_posts_create_url
    assert_response :success
  end

  test "should get update" do
    get secretariat_posts_update_url
    assert_response :success
  end

  test "should get destroy" do
    get secretariat_posts_destroy_url
    assert_response :success
  end
end
