class ApplicationMailer < ActionMailer::Base
  default from: "ЭлектроМуфта <#{ENV['INFO_EMAIL']}>"
  layout 'mailer'
end
