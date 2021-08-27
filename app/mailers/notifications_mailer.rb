class NotificationsMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notifications_mailer.pending_review.subject
  #
  def pending_review(agreement: {})
    @agreement = agreement
    @to = production? ? ['erick2109@gmail.com', 'it.sipca@gmail.com','alerta.saludintegralparaiso@gmail.com'] : 'erick2109@gmail.com'
    @url = production? ? 'https://www.sistemaintegralprogramado.com/' : 'http://locahost:3001'

    mail to: @to, subject: 'Se registro un cliente que require aprobación'
  end

  private

  def production?
    Rails.env == 'production'
  end
end
