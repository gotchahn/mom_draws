class SessionsController < ApplicationController
  skip_before_action :authenticate


  def new
    if current_user.present?
      redirect_to root_path
    end
  end

  def create
    email = params[:session][:email]
    password = params[:session][:password]

    @user = User.find_by_email(email)

    if @user.present? && @user.authenticate(password)
      login(@user)
    else
      redirect_to login_path, flash: {notice: "Email o Password Incorrecto"}
    end
  end

  def destroy
    reset_session
    redirect_to root_path
  end
end
