class SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:session][:email].downcase)

    if user && user.authenticate(params[:session][:password])
      log_in user

      redirect_to root_url
    else
      flash.now[:danger] = "Email/password do not match! :_("
      render 'new'
    end
  end

  def destroy
  end

  def new
  end
end
