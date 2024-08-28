class DashboardController < ApplicationController
  def index
    @posts = current_user.posts.active

    @bookings = Booking.joins(:post)
      .where("posts.user_id = ? OR bookings.user_id = ?", current_user.id, current_user.id)
      .order(start_date: :asc)

    @last_messages = Message.joins(:conversation)
      .where(conversations: {recipient_id: current_user.id})
      .order(created_at: :desc)
      .limit(5)

    @visible_bookings = Booking.joins(:post)
      .where("posts.user_id = ? OR bookings.user_id = ? OR bookings.visible_to_user_id = ?", current_user.id, current_user.id, current_user.id)
      .order(start_date: :desc)
      .limit(5)

    @last_post = current_user.posts.order(created_at: :desc).first
    @notifications = current_user.received_notifications.where(read_at: nil).order(created_at: :desc)

    @all_bookings = Booking.joins(:post)
      .where("posts.user_id = ? OR bookings.user_id = ?", current_user.id, current_user.id)
      .count

    @completed_bookings = Booking.joins(:post)
      .where("(posts.user_id = ? OR bookings.user_id = ?) AND bookings.status = ?", current_user.id, current_user.id, Booking.statuses[:completed])
      .count

    @pending_bookings = Booking.joins(:post)
      .where("(posts.user_id = ? OR bookings.user_id = ?) AND bookings.status = ?", current_user.id, current_user.id, Booking.statuses[:pending])
      .count

    @current_month_bookings = Booking.joins(:post)
      .where("(posts.user_id = ? OR bookings.user_id = ?) AND bookings.created_at >= ? AND bookings.created_at <= ?", current_user.id, current_user.id, Time.current.beginning_of_month, Time.current.end_of_month)
      .count

    @previous_month_bookings = Booking.joins(:post)
      .where("(posts.user_id = ? OR bookings.user_id = ?) AND bookings.created_at >= ? AND bookings.created_at <= ?", current_user.id, current_user.id, Time.current.last_month.beginning_of_month, Time.current.last_month.end_of_month)
      .count

    @booking_progress = if @previous_month_bookings > 0
      ((@current_month_bookings - @previous_month_bookings) / @previous_month_bookings.to_f) * 100
    elsif @current_month_bookings > 0
      @current_month_bookings * 100.0
    else
      0.0
    end

    @total_earnings = @bookings.where(include_in_chart: true).sum(Arel.sql("COALESCE(final_price, offered_price)"))

    gon.booking_titles = @bookings.pluck('posts.title')
    gon.booking_prices = @bookings.pluck(Arel.sql("COALESCE(final_price, offered_price)"))

    gon.all_bookings = @all_bookings
    gon.completed_bookings = @completed_bookings
    gon.pending_bookings = @pending_bookings
  end

  def map
    @posts = current_user.posts.active
    @bookings = Booking.where(user: current_user)
      .or(Booking.where(post: current_user.posts))
      .order(start_date: :asc)
  end

  def update_booking_in_chart
    booking = Booking.find(params[:id])
    booking.update(include_in_chart: params[:include_in_chart] == 'true')
    head :ok
  end
end
