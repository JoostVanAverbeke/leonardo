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

def create_patients_orders_observations(municipality, hc_provider)
    25.times do
        patient = FactoryBot.create(:patient, municipality: municipality)
        puts "Created patient #{patient.first_name} #{patient.surname} in #{patient.municipality.postal_code} #{patient.municipality.city}, #{patient.municipality.country}"
        3.times do
            order = FactoryBot.create(:order, patient: patient, ordering_provider_id: hc_provider.id)
            puts "Created order #{order.placer_order_number} for patient #{patient.first_name} #{patient.surname} by provider #{hc_provider.mnemonic}"
            observations_count = rand(1..15)
            property_counts = Property.count
            observations_count.times do
                property = Property.find(rand(1..property_counts))
                observation = FactoryBot.create(:observation, patient: patient, order: order, property: property)
                puts "  Created observation #{observation.id} for order #{order.placer_order_number} (property: #{property.mnemonic}, value: #{observation.value} #{observation.unit})"
            end
        end
    end
end

Faker::Config.locale = :nl
# Create some properties for development and test environments
50.times do
    property = FactoryBot.create(:property)
    puts "Created property #{property.mnemonic} #{property.description} (Loinc: #{property.loinc_code})"
end

# Create some patients and municipalities for development and test environments
50.times do
    municipality = FactoryBot.create(:municipality)
    puts "Created municipality #{municipality.postal_code} #{municipality.city}, #{municipality.country}"

    hc_provider1 = FactoryBot.create(:hc_provider, municipality: municipality)
    puts "Created hc_provider #{hc_provider1.mnemonic} #{hc_provider1.first_name} #{hc_provider1.surname} in #{hc_provider1.municipality.postal_code} #{hc_provider1.municipality.city}, #{hc_provider1.municipality.country}"

    create_patients_orders_observations(municipality, hc_provider1)
    hc_provider2 = FactoryBot.create(:hc_provider, municipality: municipality)
    puts "Created hc_provider #{hc_provider2.mnemonic} #{hc_provider2.first_name} #{hc_provider2.surname} in #{hc_provider2.municipality.postal_code} #{hc_provider2.municipality.city}, #{hc_provider2.municipality.country}"
    create_patients_orders_observations(municipality, hc_provider2)
end

puts "Seeding completed."
