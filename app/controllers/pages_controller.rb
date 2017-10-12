# frozen_string_literal: true

class PagesController < ApplicationController
  def index
    @result = SearchService.new(params).make_search
  end

  def agreement; end

  def privacy; end

  def catalogs
    service = DocumentService.new
    @cats   = service.catalogs
    @certs  = service.certificates
  end
end
