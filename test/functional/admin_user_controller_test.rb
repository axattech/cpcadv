require 'test_helper'

class AdminUserControllerTest < ActionController::TestCase
  test "should get login" do
    get :login
    assert_response :success
  end

  test "should get logout" do
    get :logout
    assert_response :success
  end

  test "should get change_password" do
    get :change_password
    assert_response :success
  end

  test "should get forgot_password" do
    get :forgot_password
    assert_response :success
  end

end
