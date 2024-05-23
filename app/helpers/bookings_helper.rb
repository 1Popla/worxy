module BookingsHelper
  def booking_color_class(booking)
    colors = %w[bg-red-200 bg-green-200 bg-blue-200 bg-yellow-200 bg-purple-200 bg-pink-200 bg-indigo-200 bg-gray-200]
    "#{colors[booking.id % colors.size]}"
  end
end
