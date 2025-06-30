require "test_helper"

class ListingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @landlord = users(:landlord1)
    @other_landlord = users(:landlord2)
    @student = users(:student1)
    @listing = listings(:one)
    sign_in @landlord
  end

  test "should redirect index to student search path" do
    get listings_url
    assert_redirected_to student_search_path
  end

  test "should show listing" do
    get listing_url(@listing)
    assert_response :success
  end

  test "should get new" do
    get new_listing_url
    assert_response :success
  end

  test "should create listing" do
    assert_difference("Listing.count") do
      post listings_url, params: {
        listing: {
          name: "New Listing"
        }
      }
    end
    assert_redirected_to edit_step1_listing_path(Listing.last)
  end

  test "should not create listing without name" do
    post listings_url, params: {
      listing: {
        name: ""
      }
    }
    assert_redirected_to new_listing_path
    assert_equal "Name can't be blank", flash[:alert]
  end

  test "should not edit listing of another landlord" do
    sign_in @other_landlord
    get edit_listing_url(@listing)
    assert_redirected_to listings_path
    assert_equal "You are not authorized to edit this listing.", flash[:alert]
  end
end
