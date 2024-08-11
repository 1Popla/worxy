module ApplicationHelper
  def human_readable_priority(priority)
    case priority
    when 'no_priority'
      'Brak'
    when 'high_priority'
      'Wysoki'
    when 'medium_priority'
      'Średni'
    when 'low_priority'
      'Niski'
    else
      'Nieznany'
    end
  end

  def human_enum_name(enum_name, enum_key)
    translations = {
      "booking.statuses" => {
        "pending" => "Oczekujący",
        "confirmed" => "Potwierdzony",
        "completed" => "Zakończony",
        "cancelled" => "Anulowany"
      },
      "user.roles" => {
        "worker" => "Pracownik",
        "customer" => "Klient"
      }
    }

    translations.dig(enum_name.to_s, enum_key.to_s) || enum_key.to_s.humanize
  end
end
