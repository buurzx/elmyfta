# frozen_string_literal: true

# rubocop: disable Metrics/AbcSize

require 'rubyXL'

class ParserService
  attr_accessor :file, :error, :user, :prod_ids

  def initialize(file:, user: nil)
    @file = file&.tempfile
    @user = user
    @prod_ids = []
  end

  def parse_and_create
    error!('Файл не может быть пустым') && return if file.blank?

    workbook = RubyXL::Parser.parse(file)
    worksheet = workbook[0]

    products = []

    worksheet.each do |row|
      break unless row.cells.first.value
      products << { name: row.cells.first.value,
                    quantity: row.cells.second.value }
    end

    products.each do |p|
      prod = organization.products.find_or_create_by(name: p[:name])
      error!(prod.errors.full_messages) && break unless prod.valid?

      prod.update(quantity: p[:quantity])
      user.organization.products << prod
      prod_ids << prod.id
    end

    organization.products.where.not(id: prod_ids).destroy_all
  end

  def organization
    @organization ||= user.organization
  end

  def error!(msg)
    @error = msg
  end
end
