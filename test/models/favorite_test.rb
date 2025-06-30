# Created 12/4 by Troy Paschal
require "test_helper"

class FavoriteTest < ActiveSupport::TestCase
  setup do
    @user = users(:student1)
    @listing = listings(:one)
    @favorite = Favorite.new(user: @user, listing: @listing)
  end

  test "should be valid with valid attributes" do
    assert @favorite.valid?, "Favorite should be valid with a user and listing"
  end

  test "should not be valid without a user" do
    @favorite.user = nil
    assert_not @favorite.valid?, "Favorite should be invalid without a user"
    assert_includes @favorite.errors[:user], "must exist"
  end

  test "should not be valid without a listing" do
    @favorite.listing = nil
    assert_not @favorite.valid?, "Favorite should be invalid without a listing"
    assert_includes @favorite.errors[:listing], "must exist"
  end
end
