require 'test_helper'

class SettingSlsControllerTest < ActionController::TestCase
  setup do
    @setting_sl = setting_sls(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:setting_sls)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create setting_sl" do
    assert_difference('SettingSl.count') do
      post :create, setting_sl: @setting_sl.attributes
    end

    assert_redirected_to setting_sl_path(assigns(:setting_sl))
  end

  test "should show setting_sl" do
    get :show, id: @setting_sl
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @setting_sl
    assert_response :success
  end

  test "should update setting_sl" do
    put :update, id: @setting_sl, setting_sl: @setting_sl.attributes
    assert_redirected_to setting_sl_path(assigns(:setting_sl))
  end

  test "should destroy setting_sl" do
    assert_difference('SettingSl.count', -1) do
      delete :destroy, id: @setting_sl
    end

    assert_redirected_to setting_sls_path
  end
end
