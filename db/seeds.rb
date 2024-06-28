Category.create([
  { name: "Hydraulika" },
  { name: "Elektryka" },
  { name: "Stolarka" },
  { name: "Sprzątanie" },
  { name: "Ogrodnictwo" },
  { name: "Malowanie" },
  { name: "Przeprowadzki" },
  { name: "Zwalczanie Szkodników" },
  { name: "Dekarstwo" },
  { name: "Złota Rączka" },
  { name: "Klimatyzacja i Ogrzewanie" },
  { name: "Podłogi" },
  { name: "Murarstwo" },
  { name: "Ślusarstwo" },
  { name: "Naprawa AGD" },
  { name: "Mycie Okien" },
  { name: "Utrzymanie Basenów" },
  { name: "Bezpieczeństwo Domowe" },
  { name: "Wsparcie IT" },
  { name: "Zarządzanie Odpadem" },
  { name: "Kontrola Wilgotności" },
  { name: "Czyszczenie Dywanów" },
  { name: "Pranie i Prasowanie" },
  { name: "Usługi Kosmetyczne" },
  { name: "Naprawa Mebli" },
  { name: "Naprawa Komputerów" },
  { name: "Naprawa Samochodów" },
  { name: "Monitoring i Alarmy" },
  { name: "Naprawa RTV" },
  { name: "Remonty" },
  { name: "Usługi Kurierskie" },
  { name: "Serwis Okien" },
  { name: "Serwis Drzwi" },
  { name: "Czyszczenie Dachów" },
  { name: "Usługi Remontowe" },
  { name: "Instalacja Audio-Video" },
  { name: "Naprawa Sprzętu Ogrodowego" },
  { name: "Naprawa Sprzętu Sportowego" },
  { name: "Transport Mebli" }
])

# Subcategories for each main category
hydraulika = Category.find_by(name: "Hydraulika")
elektryka = Category.find_by(name: "Elektryka")
stolarka = Category.find_by(name: "Stolarka")
sprzatanie = Category.find_by(name: "Sprzątanie")
ogrodnictwo = Category.find_by(name: "Ogrodnictwo")
malowanie = Category.find_by(name: "Malowanie")
przeprowadzki = Category.find_by(name: "Przeprowadzki")
zwalczanie_szkodnikow = Category.find_by(name: "Zwalczanie Szkodników")
dekarstwo = Category.find_by(name: "Dekarstwo")
zlota_raczka = Category.find_by(name: "Złota Rączka")
klimatyzacja_ogrzewanie = Category.find_by(name: "Klimatyzacja i Ogrzewanie")
podlogi = Category.find_by(name: "Podłogi")
murarstwo = Category.find_by(name: "Murarstwo")
slusarstwo = Category.find_by(name: "Ślusarstwo")
naprawa_agd = Category.find_by(name: "Naprawa AGD")
mycie_okien = Category.find_by(name: "Mycie Okien")
utrzymanie_basenow = Category.find_by(name: "Utrzymanie Basenów")
bezpieczenstwo_domowe = Category.find_by(name: "Bezpieczeństwo Domowe")
wsparcie_it = Category.find_by(name: "Wsparcie IT")
zarzadzanie_odpadem = Category.find_by(name: "Zarządzanie Odpadem")
kontrola_wilgotnosci = Category.find_by(name: "Kontrola Wilgotności")
czyszczenie_dywanow = Category.find_by(name: "Czyszczenie Dywanów")
pranie_prasowanie = Category.find_by(name: "Pranie i Prasowanie")
uslugi_kosmetyczne = Category.find_by(name: "Usługi Kosmetyczne")
naprawa_mebli = Category.find_by(name: "Naprawa Mebli")
naprawa_komputerow = Category.find_by(name: "Naprawa Komputerów")
naprawa_samochodow = Category.find_by(name: "Naprawa Samochodów")
monitoring_alarmy = Category.find_by(name: "Monitoring i Alarmy")
naprawa_rtv = Category.find_by(name: "Naprawa RTV")
remonty = Category.find_by(name: "Remonty")
uslugi_kurierskie = Category.find_by(name: "Usługi Kurierskie")
serwis_okien = Category.find_by(name: "Serwis Okien")
serwis_drzwi = Category.find_by(name: "Serwis Drzwi")
czyszczenie_dachow = Category.find_by(name: "Czyszczenie Dachów")
uslugi_remontowe = Category.find_by(name: "Usługi Remontowe")
instalacja_audio_video = Category.find_by(name: "Instalacja Audio-Video")
naprawa_sprzetu_ogrodowego = Category.find_by(name: "Naprawa Sprzętu Ogrodowego")
naprawa_sprzetu_sportowego = Category.find_by(name: "Naprawa Sprzętu Sportowego")
transport_mebli = Category.find_by(name: "Transport Mebli")

Category.create([
  { name: "Naprawa rur", parent_id: hydraulika.id },
  { name: "Instalacja kranów", parent_id: hydraulika.id },
  { name: "Konserwacja rur", parent_id: hydraulika.id },
  { name: "Naprawa toalet", parent_id: hydraulika.id },

  { name: "Naprawa oświetlenia", parent_id: elektryka.id },
  { name: "Montaż okablowania", parent_id: elektryka.id },
  { name: "Naprawa bezpieczników", parent_id: elektryka.id },
  { name: "Instalacja gniazdek", parent_id: elektryka.id },

  { name: "Meble na wymiar", parent_id: stolarka.id },
  { name: "Renowacja mebli", parent_id: stolarka.id },
  { name: "Naprawa drzwi", parent_id: stolarka.id },
  { name: "Naprawa okien", parent_id: stolarka.id },

  { name: "Odkurzanie", parent_id: sprzatanie.id },
  { name: "Mycie podłóg", parent_id: sprzatanie.id },
  { name: "Czyszczenie łazienek", parent_id: sprzatanie.id },
  { name: "Czyszczenie kuchni", parent_id: sprzatanie.id },

  { name: "Koszenie trawników", parent_id: ogrodnictwo.id },
  { name: "Projektowanie ogrodów", parent_id: ogrodnictwo.id },
  { name: "Sadzenie roślin", parent_id: ogrodnictwo.id },
  { name: "Nawadnianie ogrodów", parent_id: ogrodnictwo.id },

  { name: "Malowanie ścian", parent_id: malowanie.id },
  { name: "Malowanie sufitów", parent_id: malowanie.id },
  { name: "Malowanie drzwi", parent_id: malowanie.id },
  { name: "Malowanie okien", parent_id: malowanie.id },

  { name: "Pakowanie", parent_id: przeprowadzki.id },
  { name: "Rozpakowywanie", parent_id: przeprowadzki.id },
  { name: "Transport", parent_id: przeprowadzki.id },
  { name: "Magazynowanie", parent_id: przeprowadzki.id },

  { name: "Zwalczanie gryzoni", parent_id: zwalczanie_szkodnikow.id },
  { name: "Zwalczanie insektów", parent_id: zwalczanie_szkodnikow.id },
  { name: "Dezynfekcja", parent_id: zwalczanie_szkodnikow.id },
  { name: "Deratyzacja", parent_id: zwalczanie_szkodnikow.id },

  { name: "Naprawa dachów", parent_id: dekarstwo.id },
  { name: "Montaż dachów", parent_id: dekarstwo.id },
  { name: "Czyszczenie dachów", parent_id: dekarstwo.id },
  { name: "Konserwacja dachów", parent_id: dekarstwo.id },

  { name: "Naprawa urządzeń", parent_id: zlota_raczka.id },
  { name: "Montaż mebli", parent_id: zlota_raczka.id },
  { name: "Naprawa okien", parent_id: zlota_raczka.id },
  { name: "Naprawa drzwi", parent_id: zlota_raczka.id },

  { name: "Instalacja klimatyzacji", parent_id: klimatyzacja_ogrzewanie.id },
  { name: "Naprawa klimatyzacji", parent_id: klimatyzacja_ogrzewanie.id },
  { name: "Instalacja ogrzewania", parent_id: klimatyzacja_ogrzewanie.id },
  { name: "Naprawa ogrzewania", parent_id: klimatyzacja_ogrzewanie.id },

  { name: "Układanie paneli", parent_id: podlogi.id },
  { name: "Układanie dywanów", parent_id: podlogi.id },
  { name: "Naprawa podłóg", parent_id: podlogi.id },
  { name: "Czyszczenie podłóg", parent_id: podlogi.id },

  { name: "Budowa ścian", parent_id: murarstwo.id },
  { name: "Tynkowanie", parent_id: murarstwo.id },
  { name: "Renowacja murów", parent_id: murarstwo.id },
  { name: "Naprawa murów", parent_id: murarstwo.id },

  { name: "Naprawa zamków", parent_id: slusarstwo.id },
  { name: "Wymiana zamków", parent_id: slusarstwo.id },
  { name: "Awaryjne otwieranie drzwi", parent_id: slusarstwo.id },
  { name: "Konserwacja zamków", parent_id: slusarstwo.id },

  { name: "Naprawa pralek", parent_id: naprawa_agd.id },
  { name: "Naprawa lodówek", parent_id: naprawa_agd.id },
  { name: "Naprawa zmywarek", parent_id: naprawa_agd.id },
  { name: "Naprawa piekarników", parent_id: naprawa_agd.id },

  { name: "Mycie szyb", parent_id: mycie_okien.id },
  { name: "Mycie ram okiennych", parent_id: mycie_okien.id },
  { name: "Mycie okien dachowych", parent_id: mycie_okien.id },
  { name: "Mycie witryn sklepowych", parent_id: mycie_okien.id },

  { name: "Czyszczenie basenów", parent_id: utrzymanie_basenow.id },
  { name: "Kontrola wody", parent_id: utrzymanie_basenow.id },
  { name: "Naprawa basenów", parent_id: utrzymanie_basenow.id },
  { name: "Montaż basenów", parent_id: utrzymanie_basenow.id },

  { name: "Instalacja alarmów", parent_id: bezpieczenstwo_domowe.id },
  { name: "Naprawa systemów alarmowych", parent_id: bezpieczenstwo_domowe.id },
  { name: "Monitoring", parent_id: bezpieczenstwo_domowe.id },
  { name: "Instalacja drzwi antywłamaniowych", parent_id: bezpieczenstwo_domowe.id },

  { name: "Naprawa komputerów", parent_id: wsparcie_it.id },
  { name: "Konfiguracja sieci", parent_id: wsparcie_it.id },
  { name: "Instalacja oprogramowania", parent_id: wsparcie_it.id },
  { name: "Naprawa drukarek", parent_id: wsparcie_it.id },

  { name: "Wywóz śmieci", parent_id: zarzadzanie_odpadem.id },
  { name: "Segregacja odpadów", parent_id: zarzadzanie_odpadem.id },
  { name: "Recykling", parent_id: zarzadzanie_odpadem.id },
  { name: "Utylizacja odpadów niebezpiecznych", parent_id: zarzadzanie_odpadem.id },

  { name: "Pomiar wilgotności", parent_id: kontrola_wilgotnosci.id },
  { name: "Usuwanie wilgoci", parent_id: kontrola_wilgotnosci.id },
  { name: "Konserwacja urządzeń pomiarowych", parent_id: kontrola_wilgotnosci.id },
  { name: "Instalacja osuszaczy", parent_id: kontrola_wilgotnosci.id },

  { name: "Czyszczenie wykładzin", parent_id: czyszczenie_dywanow.id },
  { name: "Usuwanie plam", parent_id: czyszczenie_dywanow.id },
  { name: "Czyszczenie tapicerek", parent_id: czyszczenie_dywanow.id },
  { name: "Czyszczenie dywanów orientalnych", parent_id: czyszczenie_dywanow.id },

  { name: "Pranie odzieży", parent_id: pranie_prasowanie.id },
  { name: "Prasowanie odzieży", parent_id: pranie_prasowanie.id },
  { name: "Pranie chemiczne", parent_id: pranie_prasowanie.id },
  { name: "Maglowanie", parent_id: pranie_prasowanie.id },

  { name: "Manicure", parent_id: uslugi_kosmetyczne.id },
  { name: "Pedicure", parent_id: uslugi_kosmetyczne.id },
  { name: "Masaże", parent_id: uslugi_kosmetyczne.id },
  { name: "Depilacja", parent_id: uslugi_kosmetyczne.id },

  { name: "Naprawa stołów", parent_id: naprawa_mebli.id },
  { name: "Naprawa krzeseł", parent_id: naprawa_mebli.id },
  { name: "Naprawa szaf", parent_id: naprawa_mebli.id },
  { name: "Naprawa łóżek", parent_id: naprawa_mebli.id },

  { name: "Naprawa laptopów", parent_id: naprawa_komputerow.id },
  { name: "Naprawa komputerów stacjonarnych", parent_id: naprawa_komputerow.id },
  { name: "Instalacja systemów operacyjnych", parent_id: naprawa_komputerow.id },
  { name: "Naprawa sprzętu sieciowego", parent_id: naprawa_komputerow.id },

  { name: "Naprawa silników", parent_id: naprawa_samochodow.id },
  { name: "Naprawa skrzyń biegów", parent_id: naprawa_samochodow.id },
  { name: "Wymiana opon", parent_id: naprawa_samochodow.id },
  { name: "Naprawa układu hamulcowego", parent_id: naprawa_samochodow.id },

  { name: "Monitoring domowy", parent_id: monitoring_alarmy.id },
  { name: "Monitoring firmowy", parent_id: monitoring_alarmy.id },
  { name: "Instalacja kamer", parent_id: monitoring_alarmy.id },
  { name: "Naprawa systemów monitoringu", parent_id: monitoring_alarmy.id },

  { name: "Naprawa telewizorów", parent_id: naprawa_rtv.id },
  { name: "Naprawa sprzętu audio", parent_id: naprawa_rtv.id },
  { name: "Naprawa odtwarzaczy DVD", parent_id: naprawa_rtv.id },
  { name: "Naprawa konsol do gier", parent_id: naprawa_rtv.id },

  { name: "Remonty kuchni", parent_id: remonty.id },
  { name: "Remonty łazienek", parent_id: remonty.id },
  { name: "Remonty salonów", parent_id: remonty.id },
  { name: "Remonty sypialni", parent_id: remonty.id },

  { name: "Przesyłki kurierskie krajowe", parent_id: uslugi_kurierskie.id },
  { name: "Przesyłki kurierskie międzynarodowe", parent_id: uslugi_kurierskie.id },
  { name: "Przesyłki ekspresowe", parent_id: uslugi_kurierskie.id },
  { name: "Śledzenie przesyłek", parent_id: uslugi_kurierskie.id },

  { name: "Naprawa okien", parent_id: serwis_okien.id },
  { name: "Wymiana szyb", parent_id: serwis_okien.id },
  { name: "Uszczelnianie okien", parent_id: serwis_okien.id },
  { name: "Konserwacja okien", parent_id: serwis_okien.id },

  { name: "Naprawa drzwi", parent_id: serwis_drzwi.id },
  { name: "Wymiana drzwi", parent_id: serwis_drzwi.id },
  { name: "Montaż drzwi", parent_id: serwis_drzwi.id },
  { name: "Uszczelnianie drzwi", parent_id: serwis_drzwi.id },

  { name: "Mycie dachów", parent_id: czyszczenie_dachow.id },
  { name: "Usuwanie mchu", parent_id: czyszczenie_dachow.id },
  { name: "Mycie rynien", parent_id: czyszczenie_dachow.id },
  { name: "Konserwacja dachów", parent_id: czyszczenie_dachow.id },

  { name: "Remonty generalne", parent_id: uslugi_remontowe.id },
  { name: "Wykończenia wnętrz", parent_id: uslugi_remontowe.id },
  { name: "Naprawy bieżące", parent_id: uslugi_remontowe.id },
  { name: "Konserwacja budynków", parent_id: uslugi_remontowe.id },

  { name: "Instalacja telewizorów", parent_id: instalacja_audio_video.id },
  { name: "Instalacja systemów audio", parent_id: instalacja_audio_video.id },
  { name: "Naprawa systemów audio", parent_id: instalacja_audio_video.id },
  { name: "Instalacja systemów kinowych", parent_id: instalacja_audio_video.id },

  { name: "Naprawa kosiarek", parent_id: naprawa_sprzetu_ogrodowego.id },
  { name: "Naprawa podkaszarek", parent_id: naprawa_sprzetu_ogrodowego.id },
  { name: "Naprawa nożyc do żywopłotu", parent_id: naprawa_sprzetu_ogrodowego.id },
  { name: "Naprawa dmuchaw do liści", parent_id: naprawa_sprzetu_ogrodowego.id },

  { name: "Naprawa rowerów", parent_id: naprawa_sprzetu_sportowego.id },
  { name: "Naprawa bieżni", parent_id: naprawa_sprzetu_sportowego.id },
  { name: "Naprawa sprzętu siłowego", parent_id: naprawa_sprzetu_sportowego.id },
  { name: "Naprawa sprzętu do tenisa", parent_id: naprawa_sprzetu_sportowego.id },

  { name: "Transport stołów", parent_id: transport_mebli.id },
  { name: "Transport krzeseł", parent_id: transport_mebli.id },
  { name: "Transport szaf", parent_id: transport_mebli.id },
  { name: "Transport łóżek", parent_id: transport_mebli.id }
])


hydraulika = Category.find_by(name: "Hydraulika")
elektryka = Category.find_by(name: "Elektryka")
stolarka = Category.find_by(name: "Stolarka")
ogrodnictwo = Category.find_by(name: "Ogrodnictwo")

Category.create([
  { name: "Naprawa rur", parent_id: hydraulika.id },
  { name: "Instalacja kranów", parent_id: hydraulika.id },
  { name: "Naprawa oświetlenia", parent_id: elektryka.id },
  { name: "Montaż okablowania", parent_id: elektryka.id },
  { name: "Meble na wymiar", parent_id: stolarka.id },
  { name: "Renowacja mebli", parent_id: stolarka.id },
  { name: "Koszenie trawników", parent_id: ogrodnictwo.id },
  { name: "Projektowanie ogrodów", parent_id: ogrodnictwo.id }
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
