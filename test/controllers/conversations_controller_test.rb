# Created 12/4 by Troy Paschal
require "test_helper"

class ConversationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:student1)
    @recipient = users(:landlord1)
    sign_in @user

    # Sample Conversation for test
    @conversation = Conversation.create!(
      title: "New Conversation",
      sender: @user,
      recipient: @recipient
    )
  end

  test "should get index" do
    get conversations_url
    assert_response :success
    assert_select "h1", text: "Messages"
  end

  test "should create conversation" do
    post conversations_url, params: { conversation: { title: "New Conversation", sender_id: @user.id, recipient_id: @recipient.id } }

  created_conversation = Conversation.last
  assert_equal @user.id, created_conversation.sender_id
  assert_equal @recipient.id, created_conversation.recipient_id
  assert_equal "New Conversation", created_conversation.title
  end
end
