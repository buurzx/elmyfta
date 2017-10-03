# frozen_string_literal: true

module Users
  class RegistrationsController < Devise::RegistrationsController
    def create
      @form = UserForm.new User.new(contact: true)
      @form.organization = Organization.new

      if @form.validate permitted_params
        @form.save
      else
        flash[:error] = @form.errors.messages
        respond_with @form
      end
    end

    protected

    def after_sign_up_path_for(_resource)
      root_path
    end

    def permitted_params
      params.require(:user).permit(:name, :email, organization: %i[inn name city])
    end

    def organization_params
      params.require(:user).permit(organization: %i[inn name city])[:organization]
    end
  end
end
