# Created 12/4 by Troy Paschal
require "test_helper"

class FavoritesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:student1)
    @listing = listings(:one)
    sign_in @user
  end

  test "should create favorite" do
    assert_difference("Favorite.count", 1) do
      post listing_favorites_url(@listing)
    end
    assert_redirected_to student_profile_path(@user)
  end

  test "should destroy favorite" do
    @user.favorites.create(listing: @listing)

    assert_difference("Favorite.count", -1) do
      delete listing_favorite_url(@listing, @user.favorites.first)
    end
    assert_redirected_to student_profile_path(@user)
  end
end
