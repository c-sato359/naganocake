require "test_helper"

class Pubilc::ItemsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get pubilc_items_show_url
    assert_response :success
  end

  test "should get index" do
    get pubilc_items_index_url
    assert_response :success
  end
end
