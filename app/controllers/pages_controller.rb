class PagesController < ApplicationController
  def index
    if params[:search_type] == '0' || params[:search_type].blank?
      products = Product.includes(:organization)

      if params[:q].present?
        @products = products.where('products.name ilike ?', "%#{params[:q]}%")
                            .page(params[:page]).per_page(20)
      else
        @products = products.page(params[:page]).per_page(20)
      end

    elsif params[:search_type] == '1'
      @organizations = Organization.where('organizations.name ilike ?', "%#{params[:q]}%").page(params[:page]).per_page(20)
    end
  end

  def agreement; end
  def privacy; end

  def catalogs
    service = DocumentService.new
    @cats = service.catalogs
    @certs = service.certificates
  end
end
