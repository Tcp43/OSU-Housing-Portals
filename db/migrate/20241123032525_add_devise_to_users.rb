# frozen_string_literal: true

class AddDeviseToUsers < ActiveRecord::Migration[7.2]
  def self.up
    change_table :users do |t|
      ## Database authenticatable
      t.string :encrypted_password, null: false, default: ""

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      # Uncomment and add these columns if you want to enable trackable:
      # t.integer  :sign_in_count, default: 0, null: false
      # t.datetime :current_sign_in_at
      # t.datetime :last_sign_in_at
      # t.string   :current_sign_in_ip
      # t.string   :last_sign_in_ip

      ## Lockable
      # Uncomment if you want to enable lockable:
      # t.integer  :failed_attempts, default: 0, null: false # Only if lock strategy is :failed_attempts
      # t.string   :unlock_token # Only if unlock strategy is :email or :both
      # t.datetime :locked_at
    end

    add_index :users, :email, unique: true
    add_index :users, :reset_password_token, unique: true
    # Uncomment if you added confirmable:
    # add_index :users, :confirmation_token, unique: true
    # Uncomment if you added lockable:
    # add_index :users, :unlock_token, unique: true
  end

  def self.down
    # If needed, define how to roll back these changes.
    raise ActiveRecord::IrreversibleMigration
  end
end
