# frozen_string_literal: true

module Users
  class RegistrationsController < Devise::RegistrationsController
    before_action :register_organization, only: [:create]
    before_action :configure_sign_up_params, only: [:create]
    before_action :generate_password, only: [:create]

    def configure_sign_up_params
      devise_parameter_sanitizer.permit(:sign_up, keys: %i[address phone site contact
                                                           city description file])

      return if params[:organization].blank?

      params[:user] = organization_params
      params[:user][:name] = organization_params['contact']
      params.delete(:organization)
    end

    protected

    def register_organization
      return if params[:organization].blank?

      service = OrganizationValidationService.new(organization_params)
      prms = service.validation
      flash[:alert] = service.errors
      redirect_to new_product_path(prms) if service.errors.present?
    end

    def after_sign_up_path_for(_resource)
      edit_products_path
    end

    def generate_password
      params[:user][:password] = Devise.friendly_token(6)
    end

    def organization_params
      params.require(:organization)
            .permit(:inn, :org_name, :address, :phone, :site,
                    :contact, :email, :city, :description, :file).to_hash
    end
  end
end
