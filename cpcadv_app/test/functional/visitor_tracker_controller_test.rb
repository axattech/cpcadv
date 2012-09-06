require 'test_helper'

class VisitorTrackerControllerTest < ActionController::TestCase
  test "should get track" do
    get :track
    assert_response :success
  end

end
