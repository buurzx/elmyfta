# frozen_string_literal: true

module Users
  class SessionsController < Devise::SessionsController
    def new
      @form = UserForm.new User.new(contact: true)
      @form.organization = Organization.new
      @form.validate params
      super
    end
  end
end
