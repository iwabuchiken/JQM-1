require 'test_helper'

class AiKodakasControllerTest < ActionController::TestCase
  setup do
    @ai_kodaka = ai_kodakas(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:ai_kodakas)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create ai_kodaka" do
    assert_difference('AiKodaka.count') do
      post :create, ai_kodaka: @ai_kodaka.attributes
    end

    assert_redirected_to ai_kodaka_path(assigns(:ai_kodaka))
  end

  test "should show ai_kodaka" do
    get :show, id: @ai_kodaka
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @ai_kodaka
    assert_response :success
  end

  test "should update ai_kodaka" do
    put :update, id: @ai_kodaka, ai_kodaka: @ai_kodaka.attributes
    assert_redirected_to ai_kodaka_path(assigns(:ai_kodaka))
  end

  test "should destroy ai_kodaka" do
    assert_difference('AiKodaka.count', -1) do
      delete :destroy, id: @ai_kodaka
    end

    assert_redirected_to ai_kodakas_path
  end
end
