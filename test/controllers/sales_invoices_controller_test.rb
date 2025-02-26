require "test_helper"

class SalesInvoicesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get sales_invoices_index_url
    assert_response :success
  end

  test "should get new" do
    get sales_invoices_new_url
    assert_response :success
  end

  test "should get show" do
    get sales_invoices_show_url
    assert_response :success
  end

  test "should get edit" do
    get sales_invoices_edit_url
    assert_response :success
  end
end
