# frozen_string_literal: true

class WelcomeMailer < ApplicationMailer
  def welcome_email(email, password)
    @password = password
    mail(to: email, subject: 'Успешная регистрация на портале.')
  end
end
