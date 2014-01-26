require 'test_helper'

class NlpsControllerTest < ActionController::TestCase
  setup do
    @nlp = nlps(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:nlps)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create nlp" do
    assert_difference('Nlp.count') do
      post :create, nlp: @nlp.attributes
    end

    assert_redirected_to nlp_path(assigns(:nlp))
  end

  test "should show nlp" do
    get :show, id: @nlp
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @nlp
    assert_response :success
  end

  test "should update nlp" do
    put :update, id: @nlp, nlp: @nlp.attributes
    assert_redirected_to nlp_path(assigns(:nlp))
  end

  test "should destroy nlp" do
    assert_difference('Nlp.count', -1) do
      delete :destroy, id: @nlp
    end

    assert_redirected_to nlps_path
  end
end
