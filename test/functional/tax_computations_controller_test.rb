require 'test_helper'

class TaxComputationsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:tax_computations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create tax_computation" do
    assert_difference('TaxComputation.count') do
      post :create, :tax_computation => { }
    end

    assert_redirected_to tax_computation_path(assigns(:tax_computation))
  end

  test "should show tax_computation" do
    get :show, :id => tax_computations(:one).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => tax_computations(:one).id
    assert_response :success
  end

  test "should update tax_computation" do
    put :update, :id => tax_computations(:one).id, :tax_computation => { }
    assert_redirected_to tax_computation_path(assigns(:tax_computation))
  end

  test "should destroy tax_computation" do
    assert_difference('TaxComputation.count', -1) do
      delete :destroy, :id => tax_computations(:one).id
    end

    assert_redirected_to tax_computations_path
  end
end
