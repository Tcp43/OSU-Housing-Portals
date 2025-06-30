class AddCoverImageToListings < ActiveRecord::Migration[7.2]
  def change
    add_column :listings, :has_cover_image, :boolean, default: false
  end
end
