class RenamePetsAllowedToPetFriendlyInListings < ActiveRecord::Migration[7.2]
  def change
    rename_column :listings, :pets_allowed, :pet_friendly
  end
end
