# Created 12/4 by Troy Paschal
require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @student = users(:student1)
    @landlord = users(:landlord1)
  end

  test "should get student profile" do
    sign_in @student
    get student_profile_url(@student)
    assert_response :success
  end

  test "should get landlord profile" do
    sign_in @landlord
    get landlord_profile_url(@landlord)
    assert_response :success
  end
end
