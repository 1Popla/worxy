module CalendarHelper
  def custom_month_calendar(bookings)
    content_tag :div, class: 'grid grid-cols-1 sm:grid-cols-3 md:grid-cols-7 gap-2 md:gap-4' do
      (Date.current.beginning_of_month..Date.current.end_of_month).map do |date|
        daily_bookings = bookings.select { |booking| (booking.start_date.to_date..booking.end_date.to_date).cover?(date) }
        render partial: "bookings/calendar_day", locals: {date: date, bookings: daily_bookings}
      end.join.html_safe
    end
  end
end
