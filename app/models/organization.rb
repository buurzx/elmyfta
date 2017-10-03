# frozen_string_literal: true

class Organization < ApplicationRecord
  include Storext.model

  has_many :users, inverse_of: :organization
  has_many :products, inverse_of: :organization, dependent: :destroy

  validates :name, :inn, presence: true
  validates :inn,
            uniqueness: { message: I18n.t('errors.models.organization.attributes.inn.taken') }
  validates :inn, numericality: true, length: { in: 10..12 }

  store_attributes :info do
    site String
    address String
    contact String
    phone String
    email String
  end

  def self.org_count
    Rails.cache.fetch('org_count', expires_in: 30.minutes) do
      count
    end
  end

  def contact_user
    users.where(contact: true).first
  end

  def update_user_phone
    return if user_phone.blank?

    contact_user.update_attribute(:phone, user_phone)
  end
end
