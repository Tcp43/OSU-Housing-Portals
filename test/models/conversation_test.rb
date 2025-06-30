# Created 12/4 by Troy Paschal
require "test_helper"

class ConversationTest < ActiveSupport::TestCase
  setup do
    @sender = users(:student1)
    @recipient = users(:landlord1)
    @conversation = Conversation.new(sender: @sender, recipient: @recipient, title: "Test Conversation")
  end

  test "should be valid with valid attributes" do
    assert @conversation.valid?, "Conversation should be valid with a sender, recipient, and title"
  end

  test "should not be valid without a sender" do
    @conversation.sender = nil
    assert_not @conversation.valid?, "Conversation should be invalid without a sender"
    assert_includes @conversation.errors[:sender], "must exist"
  end

  test "should not be valid without a recipient" do
    @conversation.recipient = nil
    assert_not @conversation.valid?, "Conversation should be invalid without a recipient"
    assert_includes @conversation.errors[:recipient], "must exist"
  end
end
