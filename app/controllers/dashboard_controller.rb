class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    @posts = Post.where(status: :active)
    @bookings = Booking.where(user: current_user).or(Booking.where(post: current_user.posts))
  end
end
