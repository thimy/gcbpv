require "test_helper"

class Account::StudentsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get account_students_index_url
    assert_response :success
  end

  test "should get show" do
    get account_students_show_url
    assert_response :success
  end

  test "should get edit" do
    get account_students_edit_url
    assert_response :success
  end

  test "should get update" do
    get account_students_update_url
    assert_response :success
  end

  test "should get destroy" do
    get account_students_destroy_url
    assert_response :success
  end
end
