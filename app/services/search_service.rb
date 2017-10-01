class SearchService
  # def initialize

  # end

  # def method_name
  #   if params[:search_type] == '0' || params[:search_type].blank?
  #     products = Product.includes(:organization)

  #     @products = if params[:q].present?
  #                   products.where('products.name ilike ?', "%#{params[:q]}%")
  #                           .page(params[:page]).per_page(20)
  #                 else
  #                   products.page(params[:page]).per_page(20)
  #                 end

  #   elsif params[:search_type] == '1'
  #     @organizations = Organization.where('organizations.name ilike ?', "%#{params[:q]}%")
  #                                  .page(params[:page])
  #                                  .per_page(20)
  #   end
  # end
end
