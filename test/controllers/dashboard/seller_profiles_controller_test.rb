require "test_helper"

class Dashboard::SellerProfilesControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get dashboard_seller_profiles_show_url
    assert_response :success
  end

  test "should get edit" do
    get dashboard_seller_profiles_edit_url
    assert_response :success
  end

  test "should get update" do
    get dashboard_seller_profiles_update_url
    assert_response :success
  end
end
