require 'test_helper'

class AdminControllerTest < ActionController::TestCase
  test "should get main" do
    get :main
    assert_response :success
  end

  test "should get sub1" do
    get :sub1
    assert_response :success
  end

  test "should get sub2" do
    get :sub2
    assert_response :success
  end

end
