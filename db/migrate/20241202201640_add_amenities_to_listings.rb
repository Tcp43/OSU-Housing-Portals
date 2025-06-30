class AddAmenitiesToListings < ActiveRecord::Migration[7.2]
  def change
    add_column :listings, :in_unit_laundry, :boolean, default: false
    add_column :listings, :air_conditioning, :boolean, default: false
    add_column :listings, :utilities_included, :boolean, default: false
    add_column :listings, :dishwasher, :boolean, default: false
    add_column :listings, :parking, :boolean, default: false
    add_column :listings, :furnished, :boolean, default: false
  end
end
