require 'test_helper'

class AirsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:airs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create air" do
    assert_difference('Air.count') do
      post :create, :air => { }
    end

    assert_redirected_to air_path(assigns(:air))
  end

  test "should show air" do
    get :show, :id => airs(:one).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => airs(:one).id
    assert_response :success
  end

  test "should update air" do
    put :update, :id => airs(:one).id, :air => { }
    assert_redirected_to air_path(assigns(:air))
  end

  test "should destroy air" do
    assert_difference('Air.count', -1) do
      delete :destroy, :id => airs(:one).id
    end

    assert_redirected_to airs_path
  end
end
