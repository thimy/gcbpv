require "test_helper"

class SubscriptionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @subscription = subscriptions(:one)
  end

  test "should get index" do
    get subscriptions_url
    assert_response :success
  end

  test "should get new" do
    get new_subscription_url
    assert_response :success
  end

  test "should create subscription" do
    assert_difference("Subscription.count") do
      post subscriptions_url, params: { subscription: { course_id: @subscription.course_id, paid_amount: @subscription.paid_amount, household_id: @subscription.household_id, student_id: @subscription.student_id, workshop_id: @subscription.workshop_id, year: @subscription.year } }
    end

    assert_redirected_to subscription_url(Subscription.last)
  end

  test "should show subscription" do
    get subscription_url(@subscription)
    assert_response :success
  end

  test "should get edit" do
    get edit_subscription_url(@subscription)
    assert_response :success
  end

  test "should update subscription" do
    patch subscription_url(@subscription), params: { subscription: { course_id: @subscription.course_id, paid_amount: @subscription.paid_amount, household_id: @subscription.household_id, student_id: @subscription.student_id, workshop_id: @subscription.workshop_id, year: @subscription.year } }
    assert_redirected_to subscription_url(@subscription)
  end

  test "should destroy subscription" do
    assert_difference("Subscription.count", -1) do
      delete subscription_url(@subscription)
    end

    assert_redirected_to subscriptions_url
  end
end
