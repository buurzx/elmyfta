class Users::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_account_update_params, only: [:update]
  before_action :register_organization, only: [:create]
  before_action :configure_sign_up_params, only: [:create]
  before_action :generate_password, only: [:create]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  # def create
    # super do |resource|
    #   if request.referer && !resource.valid?
    #     redirect_to_back_or_to_root(params)
    #     return
    #   end
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

  def register_organization
    return if params[:organization].blank?

    service = OrganizationValidationService.new(organization_params)
    prms = service.validation
    flash[:alert] = service.errors
    redirect_to new_product_path(prms) if service.errors.present?
  end

  def after_sign_up_path_for(resource)
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
