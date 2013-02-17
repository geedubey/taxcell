require 'test_helper'

class TaxPaidAndRefundsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:tax_paid_and_refunds)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create tax_paid_and_refund" do
    assert_difference('TaxPaidAndRefund.count') do
      post :create, :tax_paid_and_refund => { }
    end

    assert_redirected_to tax_paid_and_refund_path(assigns(:tax_paid_and_refund))
  end

  test "should show tax_paid_and_refund" do
    get :show, :id => tax_paid_and_refunds(:one).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => tax_paid_and_refunds(:one).id
    assert_response :success
  end

  test "should update tax_paid_and_refund" do
    put :update, :id => tax_paid_and_refunds(:one).id, :tax_paid_and_refund => { }
    assert_redirected_to tax_paid_and_refund_path(assigns(:tax_paid_and_refund))
  end

  test "should destroy tax_paid_and_refund" do
    assert_difference('TaxPaidAndRefund.count', -1) do
      delete :destroy, :id => tax_paid_and_refunds(:one).id
    end

    assert_redirected_to tax_paid_and_refunds_path
  end
end
