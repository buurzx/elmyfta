# frozen_string_literal: true

class ErrorNotificationService
  def self.email(text, exception, env = nil)
    msg = exception.respond_to?(:message) ? exception.message : exception
    ExceptionNotifier.notify_exception(
      exception,
      env: env,
      data: { message: "#{text} #{msg}",
              environment: Rails.env }
    )
  end
end
