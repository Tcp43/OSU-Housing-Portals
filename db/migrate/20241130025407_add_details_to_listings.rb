# File created 11/29/2024 by Yuxi Lin
# Change the price from integer to decimal and add more details to existing listing table
class AddDetailsToListings < ActiveRecord::Migration[7.2]
  def change
    change_column :listings, :rent_price, :decimal, precision: 10, scale: 4
    change_column :listings, :security_deposit, :decimal, precision: 10, scale: 4
    add_column :listings, :name, :string
    add_column :listings, :unit, :string
    add_column :listings, :city, :string
    add_column :listings, :state, :string
    add_column :listings, :zip, :string
    add_column :listings, :property_type, :string
    add_column :listings, :square_footage, :decimal, precision: 10, scale: 4
    add_column :listings, :move_in_date, :datetime
    add_column :listings, :lease_terms, :text
    add_column :listings, :pets_allowed, :boolean
    add_column :listings, :amenities, :text
    add_column :listings, :contact_first_name, :string
    add_column :listings, :contact_last_name, :string
    add_column :listings, :contact_email, :string
    add_column :listings, :contact_phone, :string
  end
end
