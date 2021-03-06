# frozen_string_literal: true

require 'rubyXL'

class ParserService
  attr_reader :file, :error, :user

  def initialize(file:, user: nil)
    @file = file&.tempfile
    @user = user
  end

  def parse_and_create
    before_events
    return if error

    prod_ids = handle_products
    return unless prod_ids

    destroy_old_products(prod_ids)
  end

  private

  def before_events
    error!(I18n.t('parse_service.file.errors.empty')) if file.blank?
  end

  def handle_products
    fetch_products.map! do |product|
      updated_product = update_or_create_product(product)
      break unless updated_product
      # add to organization
      user.organization.products << updated_product
      # add to array for further process
      updated_product.id
    end
  end

  def destroy_old_products(prod_ids)
    organization.products.where.not(id: prod_ids).destroy_all
  end

  def update_or_create_product(product)
    prod = organization.products.find_or_create_by(name: product[:name])
    error!(prod.errors.full_messages) && return unless prod.valid?

    prod.tap do |p|
      p.update_column(:quantity, product[:quantity])
    end
  end

  def fetch_products
    products  = []
    workbook  = RubyXL::Parser.parse(file)
    worksheet = workbook[0]

    worksheet.each do |row|
      break unless row.cells.first.value

      products << { name:     row.cells.first.value,
                    quantity: row.cells.second.value }
    end

    products
  end

  def organization
    @organization ||= user.organization
  end

  def error!(msg)
    @error = msg
  end
end
