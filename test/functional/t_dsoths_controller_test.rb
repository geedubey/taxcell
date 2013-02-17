require 'test_helper'

class TDsothsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:t_dsoths)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create t_dsoth" do
    assert_difference('TDsoth.count') do
      post :create, :t_dsoth => { }
    end

    assert_redirected_to t_dsoth_path(assigns(:t_dsoth))
  end

  test "should show t_dsoth" do
    get :show, :id => t_dsoths(:one).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => t_dsoths(:one).id
    assert_response :success
  end

  test "should update t_dsoth" do
    put :update, :id => t_dsoths(:one).id, :t_dsoth => { }
    assert_redirected_to t_dsoth_path(assigns(:t_dsoth))
  end

  test "should destroy t_dsoth" do
    assert_difference('TDsoth.count', -1) do
      delete :destroy, :id => t_dsoths(:one).id
    end

    assert_redirected_to t_dsoths_path
  end
end
