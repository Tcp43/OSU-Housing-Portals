require "test_helper"

class StudentSearchesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @student_user = users(:student1)
    @admin_user = users(:admin)
    @posted_listing = listings(:one)
    @draft_listing = listings(:two)
  end

  # Test student access to search
  test "should only show posted listings to students" do
    sign_in @student_user
    get student_search_url
    assert_response :success
    assert_includes assigns(:listings), @posted_listing
    assert_not_includes assigns(:listings), @draft_listing
  end

  # Test admin access to search
  test "should show all listings to admins" do
    sign_in @admin_user
    get student_search_url
    assert_response :success
    assert_includes assigns(:listings), @posted_listing
    assert_includes assigns(:listings), @draft_listing
  end

  # Test the search bar filter
  test "should filter listings by search term for students" do
    sign_in @student_user
    get student_search_url, params: { search: "Main" }
    assert_includes assigns(:listings), @posted_listing
    assert_not_includes assigns(:listings), @draft_listing
  end

  # Test handling of no matching results for students
  test "should handle no matching results for students" do
    sign_in @student_user
    get student_search_url, params: { search: "NonExistentLocation" }
    assert assigns(:listings).empty?
  end

  # Test bedroom filter for students
  test "should filter listings by bedroom count for students" do
    sign_in @student_user
    get student_search_url, params: { bedroom: "2" }
    assert_includes assigns(:listings), @posted_listing
    assert_not_includes assigns(:listings), @draft_listing

    get student_search_url, params: { bedroom: "5+" }
    assert_not_includes assigns(:listings), @posted_listing
  end

  # Test bathroom filter for students
  test "should filter listings by bathroom count for students" do
    sign_in @student_user
    get student_search_url, params: { bathroom: "4+" }
    assert_not_includes assigns(:listings), @posted_listing
    assert_not_includes assigns(:listings), @draft_listing
  end

  # Test rent range filter for students
  test "should filter listings by rent range for students" do
    sign_in @student_user
    get student_search_url, params: { min_rent: 1000, max_rent: 1500 }
    assert_includes assigns(:listings), @posted_listing
    assert_not_includes assigns(:listings), @draft_listing
  end

  # Test amenities filter for students
  test "should filter listings by amenities for students" do
    sign_in @student_user
    get student_search_url, params: { amenities: [ "in_unit_washer_dryer" ] }
    assert_includes assigns(:listings), @posted_listing
    assert_not_includes assigns(:listings), @draft_listing

    get student_search_url, params: { amenities: [ "air_conditioning" ] }
    assert_includes assigns(:listings), @posted_listing
    assert_not_includes assigns(:listings), @draft_listing
  end

  # Test property type filter for students
  test "should filter listings by property type for students" do
    sign_in @student_user
    get student_search_url, params: { property_type: "Apartment" }
    assert_includes assigns(:listings), @posted_listing
    assert_not_includes assigns(:listings), @draft_listing
  end

  # Test multiple filters for students
  test "should apply multiple filters correctly for students" do
    sign_in @student_user
    get student_search_url, params: { search: "Main", bedroom: "2", max_rent: 1500 }
    assert_includes assigns(:listings), @posted_listing
    assert_not_includes assigns(:listings), @draft_listing
  end
end
