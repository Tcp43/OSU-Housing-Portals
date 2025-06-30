# Created 12/4 by Troy Paschal
require "test_helper"

class MessageTest < ActiveSupport::TestCase
  setup do
    @sender = users(:student1)
    @recipient = users(:landlord1)
    @conversation = conversations(:one)
    @message = Message.new(
      body: "Test message body",
      conversation: @conversation,
      sender: @sender
    )
  end

  test "should not be valid without a body" do
    @message.body = nil
    assert_not @message.valid?, "Message should be invalid without a body"
    assert_includes @message.errors[:body], "can't be blank"
  end

  test "should not be valid without a sender" do
    @message.sender = nil
    assert_not @message.valid?, "Message should be invalid without a sender"
    assert_includes @message.errors[:sender], "must exist"
  end

  test "should not be valid without a conversation" do
    @message.conversation = nil
    assert_not @message.valid?, "Message should be invalid without a conversation"
    assert_includes @message.errors[:conversation], "must exist"
  end
end
