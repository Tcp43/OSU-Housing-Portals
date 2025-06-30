class AddSenderAndRecipientToMessages < ActiveRecord::Migration[7.2]
  def change
    add_column :messages, :sender_id, :integer
    add_column :messages, :recipient_id, :integer
    add_index :messages, :sender_id
    add_index :messages, :recipient_id
  end
end
