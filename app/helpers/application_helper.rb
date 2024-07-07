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
end
