class OrganizationsController < ApplicationController
  before_action :authenticate_user!, except: :show
  before_action :find_org, only: [:edit, :update, :show]

  def edit; end

  def update
    if @org.update(org_params)
      session[:errors] = nil
      flash[:notice] = 'Данные организации успешно обновлены'
      redirect_to @org
    else
      flash[:alert] = 'При обновлении возкнилки ошибки'
      session[:errors] = @org.errors.full_messages
      redirect_to edit_organization_path(@org)
    end
  end

  def show
    unless @org
      flash[:alert] = 'Такой организации не найдено.'
      redirect_to :back
    end
    @products = @org.products
  end

  private

  def find_org
    @org = Organization.find_by(id: params[:id])
  end

  def org_params
    params.require(:organization).permit(:name, :inn, :address, :email, :phone,
                                         :contact, :city, :description, :site, :user_phone)
  end
end
