class ProductsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authenticate_user!, except: [:new, :show]

  def new
    @form = UserForm.new User.new(contact: true)
    @form.organization = Organization.new

    @form.validate params.permit!.except('controller', 'action') if params.present?
  end

  def show
    @product = Product.friendly.find_by(slug: params[:id])
    unless @product
      flash[:alert] =
        ['К сожалению, искомая позиция у производителя на данный момент отсутствует.',
         'Возможно она есть в наличии у других поставщиков.',
         'Воспользуйтесь поиском по порталу.']

      redirect_to root_path
      return
    end

    @org = @product.organization
    @products = @org.products
  end

  def create
    service = ParserService.new(file: params[:file], user: current_user)
    service.parse_and_create
    session[:errors] = nil

    if service.error.blank?
      flash[:notice] = 'Подгрузка остатков прошла успешно'
      redirect_to current_user.organization if current_user
    else
      session[:errors] = service.error
      redirect_to new_product_path
    end
  end

  def edit
    @product = Product.new
    @org = current_user.organization
  end
end
