class UsersController < ApplicationController

  before_action :check_role, except: [:profile, :destroy]

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

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update_attributes(user_params)
      redirect_to users_path, notice: "Usuario Agregado"
    else
      flash.now[:error] = "Debes corregir los datos ingresados."
      render :new
    end
  end

  def destroy
    @user = current_user

    if @user.destroy
      reset_session
      redirect_to root_path
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
