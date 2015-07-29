class UsersController < ApplicationController
  before_action :logged_in_user, only: [:destroy, :edit, :index, :update]
  before_action :admin_user,     only: [:destroy]

  def create
    @user = User.new(user_params)

    if @user.save
      log_in @user
      # FIXME Add flash
      redirect_to @user
    else
      render 'new'
    end
  end

  def index
    @users = User.paginate(page: params[:page])
  end

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
  end

  private

  def admin_user
    if !current.admin?
      flash[:danger] = "Only admin can do that"
      redirect_to root_url
    end
  end

  def logged_in_user
    if !current_user
      flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end

  def user_params
    params.require(:user).permit(:username, :email, :password,
                                 :password_confirmation)
  end
end
