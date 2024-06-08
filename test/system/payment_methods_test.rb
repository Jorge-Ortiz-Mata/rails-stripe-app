require "application_system_test_case"

class PaymentMethodsTest < ApplicationSystemTestCase
  setup do
    @payment_method = payment_methods(:one)
  end

  test "visiting the index" do
    visit payment_methods_url
    assert_selector "h1", text: "Payment methods"
  end

  test "should create payment method" do
    visit payment_methods_url
    click_on "New payment method"

    fill_in "Customer", with: @payment_method.customer_id
    fill_in "Cvc", with: @payment_method.cvc
    fill_in "Exp month", with: @payment_method.exp_month
    fill_in "Exp year", with: @payment_method.exp_year
    fill_in "Number", with: @payment_method.number
    fill_in "Type", with: @payment_method.type
    click_on "Create Payment method"

    assert_text "Payment method was successfully created"
    click_on "Back"
  end

  test "should update Payment method" do
    visit payment_method_url(@payment_method)
    click_on "Edit this payment method", match: :first

    fill_in "Customer", with: @payment_method.customer_id
    fill_in "Cvc", with: @payment_method.cvc
    fill_in "Exp month", with: @payment_method.exp_month
    fill_in "Exp year", with: @payment_method.exp_year
    fill_in "Number", with: @payment_method.number
    fill_in "Type", with: @payment_method.type
    click_on "Update Payment method"

    assert_text "Payment method was successfully updated"
    click_on "Back"
  end

  test "should destroy Payment method" do
    visit payment_method_url(@payment_method)
    click_on "Destroy this payment method", match: :first

    assert_text "Payment method was successfully destroyed"
  end
end
