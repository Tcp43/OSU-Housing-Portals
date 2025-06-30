# Created 12/4 by Koury Harmon
require "test_helper"

class LandingControllerTest < ActionDispatch::IntegrationTest
  test "should get home for guest user" do
    get home_url
    assert_response :success
    assert_select "h1", "Welcome to the OSU Off-Campus Housing Portal"
  end

  test "should redirect signed-in user to dashboard" do
    sign_in users(:student1)
    get home_url
    assert_redirected_to dashboard_url
  end

  test "should show favorites on student dashboard" do
    sign_in users(:student1)
    get dashboard_url
    assert_response :success
    assert_select "h3", "My Favorites"
  end

  test "should show listings on landlord dashboard" do
    sign_in users(:landlord1)
    get dashboard_url
    assert_response :success
    assert_select "h3", "My Listings"
  end

  test "should redirect users who are not signed in to the home page" do
    get dashboard_url
    assert_redirected_to home_url
    assert_equal "You must be signed in to view your dashboard.", flash[:alert]
  end
end
