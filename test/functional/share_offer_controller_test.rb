require 'test_helper'

class ShareOfferControllerTest < ActionController::TestCase
  test "should get CreateLink" do
    get :CreateLink
    assert_response :success
  end

end
