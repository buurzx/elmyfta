class SearchService
  attr_reader :params, :search_type

  def initialize(params)
    @params      = params
    @search_type = params[:search_type]
  end

  def make_search
    return result('products', products_scope) if search_for_products?

    result('organizations', organizations_scope)
  end

  private

  def search_for_products?
    search_type.blank? || search_type == '0'
  end

  def result(type, objects)
    { type: type, objects: objects }
  end

  def products_scope
    products = Product.includes(:organization)
    products = products.with_name(params[:q]) if params[:q].present?

    products.page(params[:page]).per_page(20)
  end

  def organizations_scope
    Organization.with_name(params[:q])
                .page(params[:page])
                .per_page(20)
  end
end
