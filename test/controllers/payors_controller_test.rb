require "test_helper"

class PayorsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @payor = payors(:one)
  end

  test "should get index" do
    get payors_url
    assert_response :success
  end

  test "should get new" do
    get new_payor_url
    assert_response :success
  end

  test "should create payor" do
    assert_difference("Payor.count") do
      post payors_url, params: { payor: { email: @payor.email, first_name: @payor.first_name, last_name: @payor.last_name, phone: @payor.phone } }
    end

    assert_redirected_to payor_url(Payor.last)
  end

  test "should show payor" do
    get payor_url(@payor)
    assert_response :success
  end

  test "should get edit" do
    get edit_payor_url(@payor)
    assert_response :success
  end

  test "should update payor" do
    patch payor_url(@payor), params: { payor: { email: @payor.email, first_name: @payor.first_name, last_name: @payor.last_name, phone: @payor.phone } }
    assert_redirected_to payor_url(@payor)
  end

  test "should destroy payor" do
    assert_difference("Payor.count", -1) do
      delete payor_url(@payor)
    end

    assert_redirected_to payors_url
  end
end
