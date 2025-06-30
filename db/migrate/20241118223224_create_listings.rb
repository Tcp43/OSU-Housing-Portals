class CreateListings < ActiveRecord::Migration[7.2]
  def change
    create_table :listings do |t|
      t.string :address
      t.integer :bedroom
      t.integer :bathroom

      t.timestamps
    end
  end
end
