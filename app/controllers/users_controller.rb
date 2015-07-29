class UsersController < ApplicationController
  before_action :logged_in_user, only: [:destroy, :edit, :index, :update]
  before_action :correct_user,   only: [:edit, :update]
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

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User kicked outta dah Clubhouse!"
    redirect_to users_url
  end

  def edit
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

  def update
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  private

  def admin_user
    if !current_user.admin?
      flash[:danger] = "Only admin can do that"
      redirect_to root_url
    end
  end

  # Confirms the correct user
  def correct_user
    user = User.find(params[:id])

    if !current_user?(user)
      redirect_to(root_url)
    end

    @user = user
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
