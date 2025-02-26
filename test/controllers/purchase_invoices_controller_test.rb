require "test_helper"

class PurchaseInvoicesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get purchase_invoices_index_url
    assert_response :success
  end

  test "should get new" do
    get purchase_invoices_new_url
    assert_response :success
  end

  test "should get show" do
    get purchase_invoices_show_url
    assert_response :success
  end

  test "should get edit" do
    get purchase_invoices_edit_url
    assert_response :success
  end
end
