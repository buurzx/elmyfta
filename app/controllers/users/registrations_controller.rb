# frozen_string_literal: true

module Users
  class RegistrationsController < Devise::RegistrationsController
    before_action :register_organization, only: [:create]
    before_action :configure_sign_up_params, only: [:create]
    before_action :generate_password, only: [:create]

    def create
      @form = UserForm.new User.new(contact: true)
      @form.organization = Organization.new

      if @form.validate permitted_params
        @form.save
        flash[:notice] = 'Регистрация успешна! Вам было отправлено письмо с паролем.'
        redirect_to edit_products_path
      else
        flash[:error] = @form.errors.messages
        respond_with @form
      end
    end

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

    # def organization_params
    #   params.require(:organization)
    #         .permit(:inn, :org_name, :address, :phone, :site,
    #                 :contact, :email, :city, :description, :file).to_hash
    # end
  # end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:address, :phone, :site, :contact,
                                                       :city, :description, :file])

    return if params[:organization].blank?

    params[:user] = organization_params
    params[:user][:name] = organization_params['contact']
    params.delete(:organization)
  end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end

  protected

    def permitted_params
      params.require(:user).permit(:name, :email, organization: %i[inn name city])
    end

    def organization_params
      params.require(:user).permit(organization: %i[inn name city])[:organization]
    end

  def organization_params
    params.require(:organization)
          .permit(:inn, :org_name, :address, :phone, :site,
                  :contact, :email, :city, :description, :file).to_hash
  end
end
