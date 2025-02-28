require "test_helper"

class OrganizationsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get organiztaoins_index_url
    assert_response :success
  end

  test "should get new" do
    get organiztaoins_new_url
    assert_response :success
  end

  test "should get show" do
    get organiztaoins_show_url
    assert_response :success
  end

  test "should get edit" do
    get organiztaoins_edit_url
    assert_response :success
  end
end
