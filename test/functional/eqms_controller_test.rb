require 'test_helper'

class EqmsControllerTest < ActionController::TestCase
  setup do
    @eqm = eqms(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:eqms)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create eqm" do
    assert_difference('Eqm.count') do
      post :create, eqm: @eqm.attributes
    end

    assert_redirected_to eqm_path(assigns(:eqm))
  end

  test "should show eqm" do
    get :show, id: @eqm
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @eqm
    assert_response :success
  end

  test "should update eqm" do
    put :update, id: @eqm, eqm: @eqm.attributes
    assert_redirected_to eqm_path(assigns(:eqm))
  end

  test "should destroy eqm" do
    assert_difference('Eqm.count', -1) do
      delete :destroy, id: @eqm
    end

    assert_redirected_to eqms_path
  end
end
