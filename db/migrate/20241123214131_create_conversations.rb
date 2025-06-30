class CreateConversations < ActiveRecord::Migration[7.2]
  def change
    create_table :conversations do |t|
      t.integer :student_id
      t.integer :landlord_id

      t.timestamps
    end
    add_index :conversations, :sender_id
    add_index :conversations, :recipient_id
    add_index :conversations, [ :sender_id, :recipient_id ], unique: true
  end
end
