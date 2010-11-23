require 'test_helper'

class PrizesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:prizes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create prize" do
    assert_difference('Prize.count') do
      post :create, :prize => { }
    end

    assert_redirected_to prize_path(assigns(:prize))
  end

  test "should show prize" do
    get :show, :id => prizes(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => prizes(:one).to_param
    assert_response :success
  end

  test "should update prize" do
    put :update, :id => prizes(:one).to_param, :prize => { }
    assert_redirected_to prize_path(assigns(:prize))
  end

  test "should destroy prize" do
    assert_difference('Prize.count', -1) do
      delete :destroy, :id => prizes(:one).to_param
    end

    assert_redirected_to prizes_path
  end
end
