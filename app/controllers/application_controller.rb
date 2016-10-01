class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user
  before_action :authenticate

  def current_user
    if session[:user_id].present?
      @current_user = User.find(session[:user_id])
    end
  end

  def login(user)
    session[:user_id] = user.id
    cookies[:user_email] = user.email
    redirect_to events_path
  end

  def authenticate
    unless current_user.present?
      redirect_to login_path
    end
  end
end
