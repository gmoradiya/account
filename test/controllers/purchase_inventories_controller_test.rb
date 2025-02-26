require "test_helper"

class PurchaseInventoriesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get purchase_inventories_index_url
    assert_response :success
  end

  test "should get show" do
    get purchase_inventories_show_url
    assert_response :success
  end

  test "should get edit" do
    get purchase_inventories_edit_url
    assert_response :success
  end
end
