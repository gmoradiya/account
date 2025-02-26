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

countries = [
  { name: "Afghanistan", iso_code: "AF" },
  { name: "Albania", iso_code: "AL" },
  { name: "Algeria", iso_code: "DZ" },
  { name: "Andorra", iso_code: "AD" },
  { name: "Angola", iso_code: "AO" },
  { name: "Argentina", iso_code: "AR" },
  { name: "Armenia", iso_code: "AM" },
  { name: "Australia", iso_code: "AU" },
  { name: "Austria", iso_code: "AT" },
  { name: "Azerbaijan", iso_code: "AZ" },
  { name: "Bahamas", iso_code: "BS" },
  { name: "Bahrain", iso_code: "BH" },
  { name: "Bangladesh", iso_code: "BD" },
  { name: "Barbados", iso_code: "BB" },
  { name: "Belarus", iso_code: "BY" },
  { name: "Belgium", iso_code: "BE" },
  { name: "Belize", iso_code: "BZ" },
  { name: "Benin", iso_code: "BJ" },
  { name: "Bhutan", iso_code: "BT" },
  { name: "Bolivia", iso_code: "BO" },
  { name: "Bosnia and Herzegovina", iso_code: "BA" },
  { name: "Botswana", iso_code: "BW" },
  { name: "Brazil", iso_code: "BR" },
  { name: "Brunei", iso_code: "BN" },
  { name: "Bulgaria", iso_code: "BG" },
  { name: "Burkina Faso", iso_code: "BF" },
  { name: "Burundi", iso_code: "BI" },
  { name: "Cambodia", iso_code: "KH" },
  { name: "Cameroon", iso_code: "CM" },
  { name: "Canada", iso_code: "CA" },
  { name: "Chad", iso_code: "TD" },
  { name: "Chile", iso_code: "CL" },
  { name: "China", iso_code: "CN" },
  { name: "Colombia", iso_code: "CO" },
  { name: "Comoros", iso_code: "KM" },
  { name: "Congo", iso_code: "CG" },
  { name: "Costa Rica", iso_code: "CR" },
  { name: "Croatia", iso_code: "HR" },
  { name: "Cuba", iso_code: "CU" },
  { name: "Cyprus", iso_code: "CY" },
  { name: "Czech Republic", iso_code: "CZ" },
  { name: "Denmark", iso_code: "DK" },
  { name: "Djibouti", iso_code: "DJ" },
  { name: "Dominican Republic", iso_code: "DO" },
  { name: "Ecuador", iso_code: "EC" },
  { name: "Egypt", iso_code: "EG" },
  { name: "El Salvador", iso_code: "SV" },
  { name: "Estonia", iso_code: "EE" },
  { name: "Eswatini", iso_code: "SZ" },
  { name: "Ethiopia", iso_code: "ET" },
  { name: "Fiji", iso_code: "FJ" },
  { name: "Finland", iso_code: "FI" },
  { name: "France", iso_code: "FR" },
  { name: "Gabon", iso_code: "GA" },
  { name: "Gambia", iso_code: "GM" },
  { name: "Georgia", iso_code: "GE" },
  { name: "Germany", iso_code: "DE" },
  { name: "Ghana", iso_code: "GH" },
  { name: "Greece", iso_code: "GR" },
  { name: "Guatemala", iso_code: "GT" },
  { name: "Guinea", iso_code: "GN" },
  { name: "Haiti", iso_code: "HT" },
  { name: "Honduras", iso_code: "HN" },
  { name: "Hungary", iso_code: "HU" },
  { name: "Iceland", iso_code: "IS" },
  { name: "India", iso_code: "IN" },
  { name: "Indonesia", iso_code: "ID" },
  { name: "Iran", iso_code: "IR" },
  { name: "Iraq", iso_code: "IQ" },
  { name: "Ireland", iso_code: "IE" },
  { name: "Israel", iso_code: "IL" },
  { name: "Italy", iso_code: "IT" },
  { name: "Jamaica", iso_code: "JM" },
  { name: "Japan", iso_code: "JP" },
  { name: "Jordan", iso_code: "JO" },
  { name: "Kazakhstan", iso_code: "KZ" },
  { name: "Kenya", iso_code: "KE" },
  { name: "Kuwait", iso_code: "KW" },
  { name: "Latvia", iso_code: "LV" },
  { name: "Lebanon", iso_code: "LB" },
  { name: "Lithuania", iso_code: "LT" },
  { name: "Luxembourg", iso_code: "LU" },
  { name: "Malaysia", iso_code: "MY" },
  { name: "Malta", iso_code: "MT" },
  { name: "Mexico", iso_code: "MX" },
  { name: "Mongolia", iso_code: "MN" },
  { name: "Morocco", iso_code: "MA" },
  { name: "Nepal", iso_code: "NP" },
  { name: "Netherlands", iso_code: "NL" },
  { name: "New Zealand", iso_code: "NZ" },
  { name: "Nigeria", iso_code: "NG" },
  { name: "Norway", iso_code: "NO" },
  { name: "Pakistan", iso_code: "PK" },
  { name: "Panama", iso_code: "PA" },
  { name: "Peru", iso_code: "PE" },
  { name: "Philippines", iso_code: "PH" },
  { name: "Poland", iso_code: "PL" },
  { name: "Portugal", iso_code: "PT" },
  { name: "Qatar", iso_code: "QA" },
  { name: "Romania", iso_code: "RO" },
  { name: "Russia", iso_code: "RU" },
  { name: "Saudi Arabia", iso_code: "SA" },
  { name: "Singapore", iso_code: "SG" },
  { name: "South Africa", iso_code: "ZA" },
  { name: "South Korea", iso_code: "KR" },
  { name: "Spain", iso_code: "ES" },
  { name: "Sweden", iso_code: "SE" },
  { name: "Switzerland", iso_code: "CH" },
  { name: "Thailand", iso_code: "TH" },
  { name: "Turkey", iso_code: "TR" },
  { name: "United Kingdom", iso_code: "GB" },
  { name: "United States", iso_code: "US" },
  { name: "Vietnam", iso_code: "VN" }
]

countries.each do |country|
  Country.find_or_create_by(country)
end

puts "Seeded #{Country.count} countries."

# db/seeds.rb

country = Country.find_or_create_by(name: "India", iso_code: "IN")

gst_state_codes = {
  "Andhra Pradesh" => "37",
  "Arunachal Pradesh" => "12",
  "Assam" => "18",
  "Bihar" => "10",
  "Chhattisgarh" => "22",
  "Goa" => "30",
  "Gujarat" => "24",
  "Haryana" => "06",
  "Himachal Pradesh" => "02",
  "Jharkhand" => "20",
  "Karnataka" => "29",
  "Kerala" => "32",
  "Madhya Pradesh" => "23",
  "Maharashtra" => "27",
  "Manipur" => "14",
  "Meghalaya" => "17",
  "Mizoram" => "15",
  "Nagaland" => "13",
  "Odisha" => "21",
  "Punjab" => "03",
  "Rajasthan" => "08",
  "Sikkim" => "11",
  "Tamil Nadu" => "33",
  "Telangana" => "36",
  "Tripura" => "16",
  "Uttar Pradesh" => "09",
  "Uttarakhand" => "05",
  "West Bengal" => "19",
  "Andaman and Nicobar Islands" => "35",
  "Chandigarh" => "04",
  "Dadra and Nagar Haveli and Daman and Diu" => "26",
  "Lakshadweep" => "31",
  "Delhi" => "07",
  "Puducherry" => "34",
  "Ladakh" => "38",
  "Jammu and Kashmir" => "01"
}

states = [
  { name: "Andhra Pradesh", code: "AP", country_id: country.id },
  { name: "Arunachal Pradesh", code: "AR", country_id: country.id },
  { name: "Assam", code: "AS", country_id: country.id },
  { name: "Bihar", code: "BR", country_id: country.id },
  { name: "Chhattisgarh", code: "CG", country_id: country.id },
  { name: "Goa", code: "GA", country_id: country.id },
  { name: "Gujarat", code: "GJ", country_id: country.id },
  { name: "Haryana", code: "HR", country_id: country.id },
  { name: "Himachal Pradesh", code: "HP", country_id: country.id },
  { name: "Jharkhand", code: "JH", country_id: country.id },
  { name: "Karnataka", code: "KA", country_id: country.id },
  { name: "Kerala", code: "KL", country_id: country.id },
  { name: "Madhya Pradesh", code: "MP", country_id: country.id },
  { name: "Maharashtra", code: "MH", country_id: country.id },
  { name: "Manipur", code: "MN", country_id: country.id },
  { name: "Meghalaya", code: "ML", country_id: country.id },
  { name: "Mizoram", code: "MZ", country_id: country.id },
  { name: "Nagaland", code: "NL", country_id: country.id },
  { name: "Odisha", code: "OR", country_id: country.id },
  { name: "Punjab", code: "PB", country_id: country.id },
  { name: "Rajasthan", code: "RJ", country_id: country.id },
  { name: "Sikkim", code: "SK", country_id: country.id },
  { name: "Tamil Nadu", code: "TN", country_id: country.id },
  { name: "Telangana", code: "TG", country_id: country.id },
  { name: "Tripura", code: "TR", country_id: country.id },
  { name: "Uttar Pradesh", code: "UP", country_id: country.id },
  { name: "Uttarakhand", code: "UK", country_id: country.id },
  { name: "West Bengal", code: "WB", country_id: country.id },
  { name: "Andaman and Nicobar Islands", code: "AN", country_id: country.id },
  { name: "Chandigarh", code: "CH", country_id: country.id },
  { name: "Dadra and Nagar Haveli and Daman and Diu", code: "DN", country_id: country.id },
  { name: "Lakshadweep", code: "LD", country_id: country.id },
  { name: "Delhi", code: "DL", country_id: country.id },
  { name: "Puducherry", code: "PY", country_id: country.id },
  { name: "Ladakh", code: "LA", country_id: country.id },
  { name: "Jammu and Kashmir", code: "JK", country_id: country.id }
]

# Adding GST Code to Each State
states.each do |state|
  state[:gst_code] = "#{gst_state_codes[state[:name]]}-#{state[:name]}"
end

puts states

states.each do |state|
  State.find_or_create_by(state)
end

puts "Seeded #{State.count} Indian states."

state = State.find_by(name: "Gujarat")

def default_financial_year
  current_year = Date.today.year
  if Date.today.month < 4
    "#{(current_year - 1) % 100}-#{current_year % 100}"
  else
    "#{current_year % 100}-#{(current_year + 1) % 100}"
  end
end

organization = Organization.create(
  name: "LAXMI CREATION",
  phone_number: "9999999999",
  gst_detail: "24g124923923kdjlf",
  full_address: "First Floor, \n Near Flower MArket",
  bank_name: "PRIME CO-OP.BANK LTD.",
  account_number: "10302001002504",
  ifcs_code: "PMEC0100304",
  branch: "KATARGAM",
  country: country,
  state: state,
  financial_year: default_financial_year
)

users = User.create!([
  { name: "super_admin", email: "sadmin@gmail.com", password: "password", password_confirmation: "password", role: "super_admin" },
  { name: "admin", email: "admin@gmail.com", password: "password", password_confirmation: "password", role: "admin" }
  # { name: "staff 1", email: "staff1@gmail.com", password: "password", password_confirmation: "password", role: "staff" },
  # { name: "staff 2", email: "staff2@gmail.com", password: "password", password_confirmation: "password", role: "staff" },
  # { name: "recenptionist", email: "receptionist@gmail.com", password: "password", password_confirmation: "password", role: "receptionist" }
])



users.each do |user|
  UserOrganization.create(user: user, organization: organization)
end
