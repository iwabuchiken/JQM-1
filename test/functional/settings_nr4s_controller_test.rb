require 'test_helper'

class SettingsNr4sControllerTest < ActionController::TestCase
  setup do
    @settings_nr4 = settings_nr4s(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:settings_nr4s)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create settings_nr4" do
    assert_difference('SettingsNr4.count') do
      post :create, settings_nr4: @settings_nr4.attributes
    end

    assert_redirected_to settings_nr4_path(assigns(:settings_nr4))
  end

  test "should show settings_nr4" do
    get :show, id: @settings_nr4
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @settings_nr4
    assert_response :success
  end

  test "should update settings_nr4" do
    put :update, id: @settings_nr4, settings_nr4: @settings_nr4.attributes
    assert_redirected_to settings_nr4_path(assigns(:settings_nr4))
  end

  test "should destroy settings_nr4" do
    assert_difference('SettingsNr4.count', -1) do
      delete :destroy, id: @settings_nr4
    end

    assert_redirected_to settings_nr4s_path
  end
end
