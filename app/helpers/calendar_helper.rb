module CalendarHelper
  def custom_month_calendar(bookings)
    month_calendar do |date|
      daily_bookings = bookings.select { |booking| (booking.start_date.to_date..booking.end_date.to_date).cover?(date) }
      render partial: 'bookings/calendar_day', locals: { date: date, bookings: daily_bookings }
    end
  end
end
