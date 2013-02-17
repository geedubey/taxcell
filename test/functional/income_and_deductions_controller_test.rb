require 'test_helper'

class IncomeAndDeductionsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:income_and_deductions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create income_and_deduction" do
    assert_difference('IncomeAndDeduction.count') do
      post :create, :income_and_deduction => { }
    end

    assert_redirected_to income_and_deduction_path(assigns(:income_and_deduction))
  end

  test "should show income_and_deduction" do
    get :show, :id => income_and_deductions(:one).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => income_and_deductions(:one).id
    assert_response :success
  end

  test "should update income_and_deduction" do
    put :update, :id => income_and_deductions(:one).id, :income_and_deduction => { }
    assert_redirected_to income_and_deduction_path(assigns(:income_and_deduction))
  end

  test "should destroy income_and_deduction" do
    assert_difference('IncomeAndDeduction.count', -1) do
      delete :destroy, :id => income_and_deductions(:one).id
    end

    assert_redirected_to income_and_deductions_path
  end
end
