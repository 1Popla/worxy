class DashboardController < ApplicationController
  def index
    @posts = current_user.posts.active
    @bookings = Booking.where(user: current_user)
      .or(Booking.where(post: current_user.posts))
      .order(start_date: :asc)
    @last_messages = Message.joins(:conversation)
      .where(conversations: {recipient_id: current_user.id})
      .order(created_at: :desc)
      .limit(5)
    @visible_bookings = Booking.where(user: current_user)
      .or(Booking.where(post_id: current_user.posts.select(:id)))
      .or(Booking.where(visible_to_user_id: current_user.id))
      .order(start_date: :desc)
      .limit(5)
    @last_post = current_user.posts.order(created_at: :desc).first
  end

  def map
    @posts = current_user.posts.active
    @bookings = Booking.where(user: current_user)
      .or(Booking.where(post: current_user.posts))
      .order(start_date: :asc)
  end
end
