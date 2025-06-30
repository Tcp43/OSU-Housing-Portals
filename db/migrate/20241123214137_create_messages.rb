class CreateMessages < ActiveRecord::Migration[7.2]
  def change
    create_table :messages do |t|
      t.references :conversation, null: false, foreign_key: true
      t.integer :sender_id, null: false
      t.text :body, null: false

      t.timestamps
    end
  end
end
