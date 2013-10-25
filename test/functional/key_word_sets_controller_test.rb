require 'test_helper'

class KeyWordSetsControllerTest < ActionController::TestCase
  setup do
    @key_word_set = key_word_sets(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:key_word_sets)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create key_word_set" do
    assert_difference('KeyWordSet.count') do
      post :create, key_word_set: @key_word_set.attributes
    end

    assert_redirected_to key_word_set_path(assigns(:key_word_set))
  end

  test "should show key_word_set" do
    get :show, id: @key_word_set
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @key_word_set
    assert_response :success
  end

  test "should update key_word_set" do
    put :update, id: @key_word_set, key_word_set: @key_word_set.attributes
    assert_redirected_to key_word_set_path(assigns(:key_word_set))
  end

  test "should destroy key_word_set" do
    assert_difference('KeyWordSet.count', -1) do
      delete :destroy, id: @key_word_set
    end

    assert_redirected_to key_word_sets_path
  end
end
