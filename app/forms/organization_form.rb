# frozen_string_literal: true

require 'reform/form/validation/unique_validator'

class OrganizationForm < Reform::Form
  property :name
  property :inn

  validates :name, :inn, presence: true
  validates :inn,
            unique: { message: I18n.t('errors.models.organization.attributes.inn.not_unique') }
  validates :inn, numericality: true, length: { in: 10..12 }
end
