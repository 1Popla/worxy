class NotificationMailer < ApplicationMailer
  default from: 'worxy.info@gmail.com'

  def offer_notification(notification)
    @notification = notification
    @recipient = notification.recipient
    @actor = notification.actor
    @post = notification.notifiable

    mail(to: @recipient.email, subject: "Masz nową ofertę w Worxy - #{@post.title}")
  end

  def request_accepted(notification)
    @notification = notification
    @recipient = @notification.actor
    @notifiable = @notification.notifiable
    mail(to: @recipient.email, subject: 'Twoja oferta została zaakceptowana')
  end

  def request_rejected(notification)
    @notification = notification
    @recipient = @notification.actor
    @notifiable = @notification.notifiable
    mail(to: @recipient.email, subject: 'Twoja oferta została odrzucona')
  end
end
