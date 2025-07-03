require "test_helper"

class Dashboard::Seller::DashboardControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get dashboard_seller_dashboard_index_url
    assert_response :success
  end
end
