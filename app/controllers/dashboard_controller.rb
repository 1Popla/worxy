class DashboardController < ApplicationController
  def index
    @posts = current_user.posts.active
    @bookings = Booking.where(user: current_user).or(Booking.where(post: current_user.posts))
                       .order(start_date: :asc)
  end

  def map
    @posts = current_user.posts.active
    @bookings = Booking.where(user: current_user).or(Booking.where(post: current_user.posts))
                       .order(start_date: :asc)
  end
end
