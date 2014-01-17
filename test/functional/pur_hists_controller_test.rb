require 'test_helper'

class PurHistsControllerTest < ActionController::TestCase
  setup do
    @pur_hist = pur_hists(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:pur_hists)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create pur_hist" do
    assert_difference('PurHist.count') do
      post :create, pur_hist: @pur_hist.attributes
    end

    assert_redirected_to pur_hist_path(assigns(:pur_hist))
  end

  test "should show pur_hist" do
    get :show, id: @pur_hist
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @pur_hist
    assert_response :success
  end

  test "should update pur_hist" do
    put :update, id: @pur_hist, pur_hist: @pur_hist.attributes
    assert_redirected_to pur_hist_path(assigns(:pur_hist))
  end

  test "should destroy pur_hist" do
    assert_difference('PurHist.count', -1) do
      delete :destroy, id: @pur_hist
    end

    assert_redirected_to pur_hists_path
  end
end
