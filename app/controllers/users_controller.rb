class UsersController < ApplicationController
  def create
    @user = User.new(user_params)

    if @user.save
      # FIXME Add flash
      redirect_to @user
    else
      render 'new'
    end
  end

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password,
                                 :password_confirmation)
  end
end