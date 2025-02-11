# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end


User.create!([
  { name: 'super_admin', email: "sadmin@gmail.com", password: "password", password_confirmation: "password" , role: 'super_admin'},
  { name: 'admin', email: "admin@gmail.com", password: "password", password_confirmation: "password" , role: 'admin'},
  { name: 'staff 1', email: "staff1@gmail.com", password: "password", password_confirmation: "password", role: 'staff' },
  { name: 'staff 2', email: "staff2@gmail.com", password: "password", password_confirmation: "password", role: 'staff' },
  { name: 'recenptionist', email: "receptionist@gmail.com", password: "password", password_confirmation: "password", role: 'receptionist' }
])


# List of common homeopathic medicines
homeopathy_medicines = [
  "Aconitum Napellus",
  "Arnica Montana",
  "Belladonna",
  "Bryonia Alba",
  "Calcarea Carbonica",
  "Cantharis",
  "Carbo Vegetabilis",
  "Chamomilla",
  "Gelsemium",
  "Hepar Sulphuris Calcareum",
  "Ignatia Amara",
  "Kali Bichromicum",
  "Lycopodium Clavatum",
  "Nux Vomica",
  "Pulsatilla",
  "Rhus Toxicodendron",
  "Sepia",
  "Silicea",
  "Sulphur",
  "Thuja Occidentalis"
]



homeopathy_medicines.each do |medicine_name|
  Medicine.find_or_create_by(name: medicine_name)
end

puts "Seeded #{homeopathy_medicines.count} homeopathy medicines into the database."


require 'faker'

2000.times do
  Patient.create(
    name: Faker::Name.name,
    address: Faker::Address.full_address,
    phone_number: Faker::PhoneNumber.cell_phone,
    email: Faker::Internet.email,
    date_of_birth: rand(Date.new(2000, 1, 1)..Date.today),
    patient_type: ['Acute', 'Chronic'].sample,
    # case_number: Patient.generate_case_number,
    sex: ['Male', 'Female'].sample,
    occupation: 'none'
  )
end