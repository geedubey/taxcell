require 'test_helper'

class TaxPsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:tax_ps)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create tax_p" do
    assert_difference('TaxP.count') do
      post :create, :tax_p => { }
    end

    assert_redirected_to tax_p_path(assigns(:tax_p))
  end

  test "should show tax_p" do
    get :show, :id => tax_ps(:one).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => tax_ps(:one).id
    assert_response :success
  end

  test "should update tax_p" do
    put :update, :id => tax_ps(:one).id, :tax_p => { }
    assert_redirected_to tax_p_path(assigns(:tax_p))
  end

  test "should destroy tax_p" do
    assert_difference('TaxP.count', -1) do
      delete :destroy, :id => tax_ps(:one).id
    end

    assert_redirected_to tax_ps_path
  end
end
