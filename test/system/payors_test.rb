require "application_system_test_case"

class PayorsTest < ApplicationSystemTestCase
  setup do
    @payor = payors(:one)
  end

  test "visiting the index" do
    visit payors_url
    assert_selector "h1", text: "Payors"
  end

  test "should create payor" do
    visit payors_url
    click_on "New payor"

    fill_in "Email", with: @payor.email
    fill_in "First name", with: @payor.first_name
    fill_in "Last name", with: @payor.last_name
    fill_in "Phone", with: @payor.phone
    click_on "Create Payor"

    assert_text "Payor was successfully created"
    click_on "Back"
  end

  test "should update Payor" do
    visit payor_url(@payor)
    click_on "Edit this payor", match: :first

    fill_in "Email", with: @payor.email
    fill_in "First name", with: @payor.first_name
    fill_in "Last name", with: @payor.last_name
    fill_in "Phone", with: @payor.phone
    click_on "Update Payor"

    assert_text "Payor was successfully updated"
    click_on "Back"
  end

  test "should destroy Payor" do
    visit payor_url(@payor)
    click_on "Destroy this payor", match: :first

    assert_text "Payor was successfully destroyed"
  end
end
