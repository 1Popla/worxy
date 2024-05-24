class NotificationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_notification, only: [:show, :accept_request, :reject_request, :destroy]

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
      Notification.create(
        recipient: @notification.actor,
        actor: current_user,
        action: "request accepted",
        notifiable: post
      )
      redirect_to bookings_path, notice: "Request accepted and booking created."
    else
      redirect_to notifications_path, alert: "Failed to create booking."
    end
  end

  def reject_request
    @notification.update(read_at: Time.zone.now)
    Notification.create(
      recipient: @notification.actor,
      actor: current_user,
      action: "request rejected",
      notifiable: @notification.notifiable
    )
    redirect_to notifications_path, notice: "Request rejected."
  end

  def destroy
    @notification.destroy
    respond_to do |format|
      format.html { redirect_to notifications_path, notice: "Notification was successfully destroyed." }
      format.turbo_stream
    end
  end

  private

  def set_notification
    @notification = Notification.find(params[:id])
  end
end
