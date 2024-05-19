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
