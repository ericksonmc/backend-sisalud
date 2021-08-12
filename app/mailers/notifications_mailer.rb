class NotificationsMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notifications_mailer.pending_review.subject
  #
  def pending_review(agreement: {})
    @agreement = agreement
    @to = production? ? 'alerta.saludintegralparaiso@gmail.com' : 'erick2109@gmail.com'
    @url = production? ? 'https://sipca-frontend.herokuapp.com/' : 'http://locahost:3001'

    mail to: @to, subject: 'Se registron un cliente que require aprobación'
  end

  private

  def production?
    Rails.env == 'production'
  end
end
