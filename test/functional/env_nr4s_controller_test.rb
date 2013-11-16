require 'test_helper'

class EnvNr4sControllerTest < ActionController::TestCase
  setup do
    @env_nr4 = env_nr4s(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:env_nr4s)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create env_nr4" do
    assert_difference('EnvNr4.count') do
      post :create, env_nr4: @env_nr4.attributes
    end

    assert_redirected_to env_nr4_path(assigns(:env_nr4))
  end

  test "should show env_nr4" do
    get :show, id: @env_nr4
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @env_nr4
    assert_response :success
  end

  test "should update env_nr4" do
    put :update, id: @env_nr4, env_nr4: @env_nr4.attributes
    assert_redirected_to env_nr4_path(assigns(:env_nr4))
  end

  test "should destroy env_nr4" do
    assert_difference('EnvNr4.count', -1) do
      delete :destroy, id: @env_nr4
    end

    assert_redirected_to env_nr4s_path
  end
end
