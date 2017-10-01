# frozen_string_literal: true

class UserForm < Reform::Form
  property :email
  property :name
  property :password, default: Devise.friendly_token(6)
  property :contact, default: true

  property :organization, form: OrganizationForm

  # property :organization,
  #          populator: ->(model:, **) { model || self.organization = OrganizationForm.new(Organization.new) }
end
