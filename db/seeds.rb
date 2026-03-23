# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# db/seeds.rb
require 'json'

file = File.read(Rails.root.join('db/data.json'))
data = JSON.parse(file)

data.each do |trip|
  Trip.create!(
    name: trip["name"],
    image_url: trip["image"],
    short_description: trip["description"],
    long_description: trip["long_description"],
    rating: trip["rating"]
  )
end