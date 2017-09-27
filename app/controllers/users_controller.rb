class UsersController < ApplicationController
  before_action :authenticate_user!

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      flash[:notice] = 'Данные успешно обновлены'
    else
      flash[:alert] = 'При обновлении возкнилки ошибки'
    end
    redirect_to :back
  end

  private

  def user_params
    params.require(:user).permit(:phone, :email, :password)
  end
end
