require 'test_helper'

class TDsalsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:t_dsals)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create t_dsal" do
    assert_difference('TDsal.count') do
      post :create, :t_dsal => { }
    end

    assert_redirected_to t_dsal_path(assigns(:t_dsal))
  end

  test "should show t_dsal" do
    get :show, :id => t_dsals(:one).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => t_dsals(:one).id
    assert_response :success
  end

  test "should update t_dsal" do
    put :update, :id => t_dsals(:one).id, :t_dsal => { }
    assert_redirected_to t_dsal_path(assigns(:t_dsal))
  end

  test "should destroy t_dsal" do
    assert_difference('TDsal.count', -1) do
      delete :destroy, :id => t_dsals(:one).id
    end

    assert_redirected_to t_dsals_path
  end
end
