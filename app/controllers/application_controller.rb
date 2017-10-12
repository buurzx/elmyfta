# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  protect_from_forgery with: :null_session

  rescue_from StandardError do |e|
    response_for_standard_error
    ErrorNotificationService.email("#{e.class.name}: ", e)
  end

  def page_not_found
    respond_to do |format|
      format.html do
        flash[:alert] = '404. Страница не найдена'
        redirect_to_back_or_to_root
      end
      format.any { head :not_found }
    end
  end

  def redirect_to_back_or_to_root(options = {})
    url = request.env['HTTP_REFERER']
    url ||= root_path
    session[:options] = options
    redirect_to url
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name inn org_name])
  end

  def response_for_standard_error
    text = I18n.t('global_errors.service_error')
    flash[:alert] = text
    redirect_to_back_or_to_root
  end
end
