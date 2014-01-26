require 'test_helper'

class NatulangsControllerTest < ActionController::TestCase
  setup do
    @natulang = natulangs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:natulangs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create natulang" do
    assert_difference('Natulang.count') do
      post :create, natulang: @natulang.attributes
    end

    assert_redirected_to natulang_path(assigns(:natulang))
  end

  test "should show natulang" do
    get :show, id: @natulang
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @natulang
    assert_response :success
  end

  test "should update natulang" do
    put :update, id: @natulang, natulang: @natulang.attributes
    assert_redirected_to natulang_path(assigns(:natulang))
  end

  test "should destroy natulang" do
    assert_difference('Natulang.count', -1) do
      delete :destroy, id: @natulang
    end

    assert_redirected_to natulangs_path
  end
end
