class BookingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_booking, only: [:show, :edit, :update, :destroy, :complete_with_offered_price, :negotiate_price]
  before_action :check_user, only: [:edit, :update, :destroy]
  before_action :check_user_view, only: [:show]
  before_action :set_selectable_users_and_posts, only: [:new, :edit, :create, :update]
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

    @month = params[:month] ? Date.parse(params[:month]) : Date.current
  end

  def show
    respond_to do |format|
      format.html
      format.json { render json: @booking.to_json(include: {post: {}, user: {}}) }
    end
  end

  def new
    @booking = Booking.new
  end

  def create
    @booking = current_user.bookings.build(booking_params)
    if @booking.save
      respond_to do |format|
        format.html { redirect_to @booking, notice: "Booking was successfully created." }
        format.turbo_stream { redirect_to @booking }
      end
    else
      respond_to do |format|
        format.html { render :new }
        format.turbo_stream { render turbo_stream: turbo_stream.replace("booking_form", partial: "form", locals: {booking: @booking}) }
      end
    end
  end

  def edit
  end

  def update
    if @booking.update(booking_params)
      respond_to do |format|
        format.html { redirect_to @booking, notice: "Booking was successfully updated." }
        format.turbo_stream { redirect_to @booking }
      end
    else
      respond_to do |format|
        format.html { render :edit }
        format.turbo_stream { render turbo_stream: turbo_stream.replace("booking_form", partial: "form", locals: {booking: @booking}) }
      end
    end
  end

  def destroy
    @booking.destroy
    respond_to do |format|
      format.html { redirect_to bookings_url, notice: "Booking was successfully destroyed." }
      format.turbo_stream
    end
  end

  def complete_with_offered_price
    @booking.update(status: "completed", offered_price: @booking.offered_price)
    redirect_to @booking, notice: "Booking completed with the offered price."
  end

  def negotiate_price
    recipient = (current_user == @booking.user) ? @booking.post.user : @booking.user

    Notification.create(
      recipient: recipient,
      actor: current_user,
      action: "sent you a negotiation request",
      notifiable: @booking,
      message: params[:message],
      price_offer: params[:new_price_offer],
      start_date_offer: @booking.start_date
    )

    redirect_to @booking, notice: "Negotiation request sent successfully."
  end

  def navigation
    @bookings = current_user.bookings.includes(:post)
  end

  private

  def set_booking
    @booking = Booking.find(params[:id])
  end

  def booking_params
    params.require(:booking).permit(:post_id, :status, :visible_to_user_id, :start_date, :end_date, :offered_price)
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

  def set_selectable_users_and_posts
    sent_notifications = Notification.where(actor_id: current_user.id, action: "sent you a request for")
    received_notifications = Notification.where(recipient_id: current_user.id, action: "sent you a request for")

    sent_user_ids = sent_notifications.pluck(:recipient_id)
    received_user_ids = received_notifications.pluck(:actor_id)
    user_ids = sent_user_ids + received_user_ids

    sent_post_ids = sent_notifications.pluck(:notifiable_id)
    received_post_ids = received_notifications.pluck(:notifiable_id)
    post_ids = sent_post_ids + received_post_ids

    @selectable_users = User.where(id: user_ids).distinct
    @selectable_posts = Post.where(id: post_ids).distinct
  end
end
