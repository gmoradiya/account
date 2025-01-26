require "test_helper"

class PrescriptionsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get prescriptions_new_url
    assert_response :success
  end
end
