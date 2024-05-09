require "test_helper"

class Ecole::InstrumentsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get ecole_instruments_index_url
    assert_response :success
  end

  test "should get show" do
    get ecole_instruments_show_url
    assert_response :success
  end
end
