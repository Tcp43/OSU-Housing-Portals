# File created 11/23 by Troy Paschal:Tracks the sender and recipient users for each chat
class Conversation < ApplicationRecord
  belongs_to :sender, class_name: "User"
  belongs_to :recipient, class_name: "User"

  has_many :messages, dependent: :destroy

  validates :sender_id, uniqueness: { scope: :recipient_id }

  # Create a conversation between two users
  def self.get(sender_id, recipient_id)
    between(sender_id, recipient_id).first_or_create(sender_id: sender_id, recipient_id: recipient_id)
  end

  scope :between, ->(sender_id, recipient_id) {
    where(sender_id: sender_id, recipient_id: recipient_id)
      .or(where(sender_id: recipient_id, recipient_id: sender_id))
  }
end
