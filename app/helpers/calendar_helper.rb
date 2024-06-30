module CalendarHelper
  def custom_month_calendar(bookings, month)
    start_date = month.beginning_of_month
    end_date = month.end_of_month

    content_tag :div do
      concat(day_names_in_polish)
      concat(content_tag(:div, class: "grid grid-cols-1 sm:grid-cols-3 md:grid-cols-7 gap-2 md:gap-4") do
        (start_date..end_date).map do |date|
          daily_bookings = bookings.select { |booking| (booking.start_date.to_date..booking.end_date.to_date).cover?(date) }
          render partial: "bookings/calendar_day", locals: {date: date, bookings: daily_bookings}
        end.join.html_safe
      end)
    end
  end

  def day_names_in_polish
    days = %w[Pon Wt Śr Czw Pt Sob Nd]
    content_tag :div, class: "grid grid-cols-7 text-center font-bold hidden sm:grid" do
      days.map { |day| concat content_tag(:div, day) }
    end
  end

  def month_name_in_polish(month)
    months = %w[Styczeń Luty Marzec Kwiecień Maj Czerwiec Lipiec Sierpień Wrzesień Październik Listopad Grudzień]
    months[month.month - 1]
  end
end
