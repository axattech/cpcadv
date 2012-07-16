require 'test_helper'

class OffersControllerTest < ActionController::TestCase
  setup do
    @offer = offers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:offers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create offer" do
    assert_difference('Offer.count') do
      post :create, offer: { offer_budget: @offer.offer_budget, offer_cr_per_click: @offer.offer_cr_per_click, offer_description: @offer.offer_description, offer_end_date: @offer.offer_end_date, offer_link: @offer.offer_link, offer_max_clicks_per_user: @offer.offer_max_clicks_per_user, offer_msg: @offer.offer_msg, offer_name: @offer.offer_name, offer_start_date: @offer.offer_start_date, offer_status: @offer.offer_status, offer_worldwide: @offer.offer_worldwide }
    end

    assert_redirected_to offer_path(assigns(:offer))
  end

  test "should show offer" do
    get :show, id: @offer
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @offer
    assert_response :success
  end

  test "should update offer" do
    put :update, id: @offer, offer: { offer_budget: @offer.offer_budget, offer_cr_per_click: @offer.offer_cr_per_click, offer_description: @offer.offer_description, offer_end_date: @offer.offer_end_date, offer_link: @offer.offer_link, offer_max_clicks_per_user: @offer.offer_max_clicks_per_user, offer_msg: @offer.offer_msg, offer_name: @offer.offer_name, offer_start_date: @offer.offer_start_date, offer_status: @offer.offer_status, offer_worldwide: @offer.offer_worldwide }
    assert_redirected_to offer_path(assigns(:offer))
  end

  test "should destroy offer" do
    assert_difference('Offer.count', -1) do
      delete :destroy, id: @offer
    end

    assert_redirected_to offers_path
  end
end
