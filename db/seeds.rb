# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require "factory_bot_rails"
require "faker"

Faker::Config.locale = :nl
# Create some patients and municipalities for development and test environments
1000.times do
    patient = FactoryBot.create(:patient)
    puts "Created patient #{patient.first_name} #{patient.surname} in #{patient.municipality.postal_code} #{patient.municipality.city}, #{patient.municipality.country}"
end
