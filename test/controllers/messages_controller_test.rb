# Created 12/4 by Troy Paschal
require "test_helper"

class MessagesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:student1)
    @recipient = users(:landlord1)
    @conversation = conversations(:one)
    sign_in @user

    # Sample message for the test
    @message = Message.create!(
      conversation: @conversation,
      sender: @user,
      recipient: @recipient,
      body: "Hello, this is a test message"
    )
  end

  test "should get index" do
    get conversation_messages_url(@conversation)
    assert_response :success
  end

  test "should create message" do
    post conversation_messages_url(@conversation), params: {
      message: {
        body: "Test message",
        sender_id: @user.id,
        recipient_id: @recipient.id
      }
    }
    created_message = @conversation.messages.last
    assert_equal "Hello, this is a test message", created_message.body
    assert_equal @user, created_message.sender
    assert_equal @recipient, created_message.recipient
  end

  test "should not create message without body" do
    assert_no_difference("Message.count") do
      post conversation_messages_url(@conversation), params: {
        message: {
          body: "",
          sender_id: @user.id,
          recipient_id: @recipient.id
        }
      }
    end
    assert_response :unprocessable_entity
  end
end
