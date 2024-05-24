# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

require "factory_bot"

FactoryBot.create(:user)

Category.create([
  {name: "Hydraulika"},
  {name: "Elektryka"},
  {name: "Stolarka"},
  {name: "Sprzątanie"},
  {name: "Ogrodnictwo"},
  {name: "Malowanie"},
  {name: "Przeprowadzki"},
  {name: "Zwalczanie Szkodników"},
  {name: "Dekarstwo"},
  {name: "Złota Rączka"},
  {name: "Klimatyzacja i Ogrzewanie"},
  {name: "Podłogi"},
  {name: "Murarstwo"},
  {name: "Ślusarstwo"},
  {name: "Naprawa AGD"},
  {name: "Mycie Okien"},
  {name: "Utrzymanie Basenów"},
  {name: "Bezpieczeństwo Domowe"},
  {name: "Wsparcie IT"}
])

country_codes = [
  {name: "Poland", code: "+48", flag: "🇵🇱"},
  {name: "Germany", code: "+49", flag: "🇩🇪"},
  {name: "France", code: "+33", flag: "🇫🇷"},
  {name: "Spain", code: "+34", flag: "🇪🇸"},
  {name: "Italy", code: "+39", flag: "🇮🇹"},
  {name: "United Kingdom", code: "+44", flag: "🇬🇧"},
  {name: "Netherlands", code: "+31", flag: "🇳🇱"},
  {name: "Belgium", code: "+32", flag: "🇧🇪"},
  {name: "Austria", code: "+43", flag: "🇦🇹"},
  {name: "Sweden", code: "+46", flag: "🇸🇪"},
  {name: "Denmark", code: "+45", flag: "🇩🇰"},
  {name: "Finland", code: "+358", flag: "🇫🇮"},
  {name: "Norway", code: "+47", flag: "🇳🇴"},
  {name: "Switzerland", code: "+41", flag: "🇨🇭"},
  {name: "Ireland", code: "+353", flag: "🇮🇪"}
]

country_codes.each do |country|
  CountryCode.find_or_create_by(name: country[:name], code: country[:code], flag: country[:flag])
end
