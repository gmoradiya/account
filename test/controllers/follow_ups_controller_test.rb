require "test_helper"

class FollowUpsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get follow_ups_index_url
    assert_response :success
  end
end
