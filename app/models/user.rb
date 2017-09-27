# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  belongs_to :organization, optional: true

  validates :name, :email, presence: true
  validates :inn, :org_name, presence: true, on: :create
  validates :inn, numericality: true, length: { in: 10..12 }, on: :create
  validate :check_organization_and_join, on: :create

  after_commit :send_welcome, :parse_products, :mark_as_contact, on: :create

  def check_organization_and_join
    org = Organization.find_by(inn: inn.strip, name: org_name.strip)
    if org
      self.organization = org
    else
      new_org = create_organization(inn: inn.strip,
                                    name: org_name.strip,
                                    contact: name,
                                    email: email,
                                    address: address,
                                    site: site,
                                    city: city,
                                    description: description)
      errors.add(:base, I18n.t('organization.inn_or_name')) unless new_org.valid?
    end
  end

  def send_welcome
    WelcomeMailer.welcome_email(email, password).deliver_later
  end

  def parse_products
    return if file.blank?

    ParserService.new(file: file, user: self).parse_and_create
  end

  def mark_as_contact
    return if organization.users.count > 1

    update_column(:contact, true)
  end
end
