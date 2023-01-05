require "test_helper"

class AdminControllerTest < ActionDispatch::IntegrationTest
  test "should get order_item" do
    get admin_order_item_url
    assert_response :success
  end
end
