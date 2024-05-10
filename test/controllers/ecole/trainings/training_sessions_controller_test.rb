require "test_helper"

class Ecole::Trainings::TrainingSessionsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get ecole_trainings_training_sessions_show_url
    assert_response :success
  end
end
