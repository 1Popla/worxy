class BookingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_booking, only: [:show, :edit, :update, :destroy]
  before_action :check_user, only: [:edit, :update, :destroy]
  before_action :check_user_view, only: [:show]
  helper CalendarHelper

  def index
    customer_or_visible_booking_ids = current_user.bookings.select(:id)
    visible_booking_ids = Booking.where(visible_to_user_id: current_user.id).select(:id)
    worker_booking_ids = Booking.joins(:post).where(posts: {user_id: current_user.id}).select(:id)

    @bookings = Booking.where(id: customer_or_visible_booking_ids + worker_booking_ids + visible_booking_ids).distinct
  end

  def calendar
    customer_or_visible_booking_ids = current_user.bookings.select(:id)
    visible_booking_ids = Booking.where(visible_to_user_id: current_user.id).select(:id)
    worker_booking_ids = Booking.joins(:post).where(posts: {user_id: current_user.id}).select(:id)

    @bookings = Booking.where(id: customer_or_visible_booking_ids + worker_booking_ids + visible_booking_ids).distinct
  end

  def show
  end

  def new
    @booking = Booking.new
  end

  def create
    @booking = current_user.bookings.build(booking_params)
    if @booking.save
      respond_to do |format|
        format.html { redirect_to @booking, notice: "Booking was successfully created." }
        format.turbo_stream
      end
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @booking.update(booking_params)
      respond_to do |format|
        format.html { redirect_to @booking, notice: "Booking was successfully updated." }
        format.turbo_stream
      end
    else
      render :edit
    end
  end

  def destroy
    @booking.destroy
    respond_to do |format|
      format.html { redirect_to bookings_url, notice: "Booking was successfully destroyed." }
      format.turbo_stream
    end
  end

  private

  def set_booking
    @booking = Booking.find(params[:id])
  end

  def booking_params
    params.require(:booking).permit(:post_id, :status, :visible_to_user_id, :start_date, :end_date)
  end

  def check_user
    unless current_user.id == @booking.user_id || current_user.id == @booking.post.user_id
      redirect_to root_path, alert: "You are not authorized to access this booking."
    end
  end

  def check_user_view
    unless current_user.id == @booking.user_id || current_user.id == @booking.post.user_id || current_user.id == @booking.visible_to_user_id
      redirect_to root_path, alert: "You are not authorized to view this booking."
    end
  end
end
