# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :organization

  validates :name, :email, presence: true
  validates :email, uniqueness: true

  after_commit :send_welcome, on: :create

  def send_welcome
    WelcomeMailer.welcome_email(email, password).deliver_later
  end

  def parse_products
    return if file.blank?

    ParserService.new(file: file, user: self).parse_and_create
  end
end
