require "test_helper"

# Created 11/23/2024 by Yuxi Lin and Troy Paschal
# Test the user model.
class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: "Example User", email: "lin.1@osu.edu", password: "password", role: "student")
  end

  # Created 11/23/2024 by Yuxi Lin and Troy Paschal
  # Validating Presence
  test "should be valid" do
    assert @user.valid?
  end
  test "name should be present" do
    @user.name = "     "
    assert_not @user.valid?
  end
  test "name should only allow letters, spaces, and underscores" do
    invalid_names = [ "Jane@Doe", "John-Doe", "John@Doe", "John!Doe", "john@osu.edu" ]
    invalid_names.each do |invalid_name|
      @user.name = invalid_name
      assert_not @user.valid?, "#{invalid_name.inspect} should be invalid"
    end
  end

  test "name should be valid with letters, spaces, and underscores" do
    valid_names = [ "John Doe", "John_Doe", "Jane Smith", "Alice_Johnson" ]
    valid_names.each do |valid_name|
      @user.name = valid_name
      assert @user.valid?, "#{valid_name.inspect} should be valid"
    end
  end

  test "name should not be too long" do
    @user.name = "a" * 51
    assert_not @user.valid?
  end

  test "email should not be too long" do
    @user.email = "a" * 244 + "@example.com"
    assert_not @user.valid?
  end

  test "email should be present" do
    @user.email = "     "
    assert_not @user.valid?
  end
  test "email should have a valid format" do
    invalid_emails = [ "user@example,com", "user_at_example.org", "user.name@example." ]
    invalid_emails.each do |invalid_email|
      @user.email = invalid_email
      assert_not @user.valid?, "#{invalid_email.inspect} should be invalid"
    end
  end
  test "email addresses should be unique" do
    duplicate_user = @user.dup
    @user.save
    assert_not duplicate_user.valid?
  end
end
