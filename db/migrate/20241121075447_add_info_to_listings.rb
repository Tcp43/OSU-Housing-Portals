class AddInfoToListings < ActiveRecord::Migration[7.2]
  def change
    add_column :listings, :description, :text
    add_column :listings, :rent_price, :integer
    add_column :listings, :available, :string
    add_column :listings, :landlord_id, :integer
    add_index :listings, :landlord_id
  end
end
