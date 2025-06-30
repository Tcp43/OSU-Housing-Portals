class AddTitleAndUserIdToConversations < ActiveRecord::Migration[7.2]
  def change
    add_column :conversations, :title, :string
    add_column :conversations, :user_id, :integer
  end
end
