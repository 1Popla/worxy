class NotificationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_notification, only: [:show, :accept_request, :reject_request, :destroy]

  def index
    @notifications = current_user.received_notifications.order(created_at: :desc)
    @notifications.update_all(read_at: Time.zone.now)
  end

  def show
    @notification.update(read_at: Time.zone.now)
  end

  def accept_request
    @notification = Notification.find(params[:id])
    notifiable = @notification.notifiable

    if notifiable.is_a?(Post)
      post = notifiable
      booking = Booking.create(
        user: @notification.actor,
        post: post,
        status: :pending,
        start_date: @notification.start_date_offer || Time.now,
        end_date: (@notification.start_date_offer || Time.now) + 1.week,
        offered_price: @notification.price_offer
      )
    elsif notifiable.is_a?(Booking)
      booking = notifiable
      booking.update(
        offered_price: @notification.price_offer,
        start_date: @notification.start_date_offer || booking.start_date,
        end_date: (@notification.start_date_offer || booking.start_date) + 1.week
      )
    end

    if booking.persisted?
      @notification.update(read_at: Time.zone.now, status: "accepted")
      Notification.create(
        recipient: @notification.actor,
        actor: current_user,
        action: "request accepted",
        notifiable: notifiable,
        price_offer: @notification.price_offer,
        start_date_offer: @notification.start_date_offer
      )
      flash[:accept_notice] = "Oferta została zaakceptowana. Pomyślnie utworzono zlecenie."
    else
      flash[:accept_alert] = "Nie udało się utworzyć zlecenia."
    end

    redirect_to notification_path(@notification)
  end

  def reject_request
    @notification.update(read_at: Time.zone.now, status: "rejected")
    Notification.create(
      recipient: @notification.actor,
      actor: current_user,
      action: "request rejected",
      notifiable: @notification.notifiable,
      price_offer: @notification.price_offer,
      start_date_offer: @notification.start_date_offer
    )
    flash[:reject_notice] = "Oferta odrzucona."
    redirect_to notification_path(@notification)
  end

  def destroy
    @notification.destroy
    flash[:notification_destroy] = "Powiadomienie usunięte."
    redirect_to notifications_path
  end

  def unread_count
    count = current_user.received_notifications.where(read_at: nil).count
    render json: {unread_count: count}
  end

  private

  def set_notification
    @notification = Notification.find(params[:id])
  end
end
