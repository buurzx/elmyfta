# frozen_string_literal: true

require 'reform/form/validation/unique_validator'

class OrganizationForm < Reform::Form
  property :name
  property :inn
  property :city
  property :site
  property :address
  property :description

  validates :name, :inn, :city, presence: true
  validates :inn,
            unique: {
              message: I18n.t('activemodel.errors.models.organization.attributes.inn.taken')
            }
  validates :inn, numericality: true, length: { in: 10..12 }
  validates :name, length: { minimum: 3 }
end
