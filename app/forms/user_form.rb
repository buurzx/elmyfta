# frozen_string_literal: true

require 'reform/form/validation/unique_validator'

class UserForm < Reform::Form
  property :email
  property :name
  property :password, default: Devise.friendly_token(6)
  property :contact, default: true
  property :phone

  property :organization, form: OrganizationForm

  validates :email, :name, presence: true
  validates :email, unique: { message: I18n.t('errors.messages.taken') }
end
