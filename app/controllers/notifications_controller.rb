class NotificationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_notification, only: [:show, :accept_request, :reject_request]

  def index
    @notifications = current_user.received_notifications.where(read_at: nil).order(created_at: :desc)
  end

  def show
  end

  def accept_request
    post = @notification.notifiable

    booking = Booking.create(
      user: @notification.actor,
      post: post,
      status: :pending,
      start_date: Time.now,
      end_date: Time.now + 1.week
    )

    if booking.persisted?
      @notification.update(read_at: Time.zone.now)
      redirect_to bookings_path, notice: 'Request accepted and booking created.'
    else
      redirect_to notifications_path, alert: 'Failed to create booking.'
    end
  end

  def reject_request
    @notification.update(read_at: Time.zone.now)
    redirect_to notifications_path, notice: 'Request rejected.'
  end

  private

  def set_notification
    @notification = Notification.find(params[:id])
  end
end
