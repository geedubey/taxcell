require 'test_helper'

class FilingInfosControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:filing_infos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create filing_info" do
    assert_difference('FilingInfo.count') do
      post :create, :filing_info => { }
    end

    assert_redirected_to filing_info_path(assigns(:filing_info))
  end

  test "should show filing_info" do
    get :show, :id => filing_infos(:one).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => filing_infos(:one).id
    assert_response :success
  end

  test "should update filing_info" do
    put :update, :id => filing_infos(:one).id, :filing_info => { }
    assert_redirected_to filing_info_path(assigns(:filing_info))
  end

  test "should destroy filing_info" do
    assert_difference('FilingInfo.count', -1) do
      delete :destroy, :id => filing_infos(:one).id
    end

    assert_redirected_to filing_infos_path
  end
end
