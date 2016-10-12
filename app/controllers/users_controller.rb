class UsersController < ApplicationController

  before_action :check_role, except: [:profile]

  def index
    @users = User.order(:name, :role)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to users_path, notice: "Usuario Agregado"
    else
      flash.now[:error] = "Debes corregir los datos ingresados."
      render :new
    end
  end

  def profile
    @user = current_user
  end

  def update
    @user = current_user

    if @user.update_attributes(user_params)
      redirect_to users_path, notice: "Usuario Agregado"
    else
      flash.now[:error] = "Debes corregir los datos ingresados."
      render :new
    end
  end

  protected

    def user_params
      params.require(:user).permit!
    end

    def check_role
      redirect_to events_path unless current_user.admin?
    end
end
