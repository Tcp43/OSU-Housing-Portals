class AddStatusToListings < ActiveRecord::Migration[7.2]
  def change
    add_column :listings, :status, :string, default: 'draft'
  end
end
