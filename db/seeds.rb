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
  {name: "Polska", code: "+48", flag: "🇵🇱"},
  {name: "Niemcy", code: "+49", flag: "🇩🇪"},
  {name: "Francja", code: "+33", flag: "🇫🇷"},
  {name: "Hiszpania", code: "+34", flag: "🇪🇸"},
  {name: "Włochy", code: "+39", flag: "🇮🇹"},
  {name: "Wielka Brytania", code: "+44", flag: "🇬🇧"},
  {name: "Holandia", code: "+31", flag: "🇳🇱"},
  {name: "Belgia", code: "+32", flag: "🇧🇪"},
  {name: "Austria", code: "+43", flag: "🇦🇹"},
  {name: "Szwecja", code: "+46", flag: "🇸🇪"},
  {name: "Dania", code: "+45", flag: "🇩🇰"},
  {name: "Finlandia", code: "+358", flag: "🇫🇮"},
  {name: "Norwegia", code: "+47", flag: "🇳🇴"},
  {name: "Szwajcaria", code: "+41", flag: "🇨🇭"},
  {name: "Irlandia", code: "+353", flag: "🇮🇪"}
]

country_codes.each do |country|
  CountryCode.find_or_create_by(name: country[:name], code: country[:code], flag: country[:flag])
end

skills = ["Hydraulika", "Elektryka", "Stolarka", "Sprzątanie", "Ogrodnictwo", "Malowanie", "Przeprowadzki", "Zwalczanie Szkodników", "Dekarstwo", "Złota Rączka", "Klimatyzacja i Ogrzewanie", "Podłogi", "Murarstwo", "Ślusarstwo", "Naprawa AGD", "Mycie Okien", "Utrzymanie Basenów", "Bezpieczeństwo Domowe", "Wsparcie IT"]
locations = ["Warszawa", "Kraków", "Łódź", "Wrocław", "Poznań", "Gdańsk", "Szczecin", "Bydgoszcz", "Lublin", "Katowice", "Cała Polska"]
experience_levels = ["0-1 lat", "1-3 lat", "3-5 lat", "5-7 lat", "7-10 lat", "10+ lat"]

Rails.configuration.x.app_data = {
  skills: skills,
  locations: locations,
  experience_levels: experience_levels
}
