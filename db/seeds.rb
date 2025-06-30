# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Edited 11/22/2024 by Koury Harmon: Added seeding data to have housing data in the website at startup


require 'faker'
require 'csv'


# Create 10 users
10.times do
  User.create(
    name: Faker::Name.name,
    email: Faker::Internet.email,
    role: [ "student", "landlord" ].sample
  )
end

csv_path = Rails.root.join('db', 'data', 'house_listings.csv')

CSV.foreach(csv_path, headers: true) do |row|
  # Create the listing
  Listing.create(
    address: row['address'],
    bedroom: row['bedroom'].to_i,
    bathroom: row['bathroom'].to_i,
    description: row['description'],
    rent_price: row['rent_price'].to_i, # Convert to integer
    available: row['available'], # Save as is (string column)
    landlord_id: row['landlord_id']
  )
end


# db/seeds.rb

(27..40).each do |id|
  listing = Listing.find_by(id: id)
  next unless listing # Skip if the listing doesn't exist

  image_path = Rails.root.join("app", "assets", "images", "#{id}.jpg")

  # Check if the file exists before attempting to attach
  if File.exist?(image_path)
    listing.cover_image.attach(
      io: File.open(image_path),
      filename: "#{id}.jpg",
      content_type: "image/jpeg"
    )
    if listing.cover_image.attached?
      puts "Image successfully attached to Listing ID: #{listing.id}"
    else
      puts "Failed to attach image to Listing ID: #{listing.id}"
    end
  else
    puts "Image file #{id}.jpg not found for Listing ID: #{id}"
  end
end
