require 'test_helper'

class VersControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:vers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create ver" do
    assert_difference('Ver.count') do
      post :create, :ver => { }
    end

    assert_redirected_to ver_path(assigns(:ver))
  end

  test "should show ver" do
    get :show, :id => vers(:one).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => vers(:one).id
    assert_response :success
  end

  test "should update ver" do
    put :update, :id => vers(:one).id, :ver => { }
    assert_redirected_to ver_path(assigns(:ver))
  end

  test "should destroy ver" do
    assert_difference('Ver.count', -1) do
      delete :destroy, :id => vers(:one).id
    end

    assert_redirected_to vers_path
  end
end
