class MamisController < ApplicationController
  def index
    @mamis = Mami.availables
  end

  def new
    @mami = Mami.new
  end

  def create
    @mami = Mami.new(mami_params)

    if @mami.save
      redirect_to mamis_path, notice: "Se ha agregado la mami exitosamente."
    else
      flash.now[:error] = "Debes corregir los datos ingresados."
      render :new
    end
  end

  def edit
    @mami = Mami.find(params[:id])
  end

  def update
    @mami = Mami.find(params[:id])

    if @mami.update_attributes(mami_params)
      redirect_to mamis_path, notice: "Se ha editado la mami exitosamente."
    else
      flash.now[:error] = "Debes corregir los datos ingresados."
      render :edit
    end
  end

  def destroy
    @mami = Mami.find(params[:id])

    if @mami.destroy
      redirect_to mamis_path, notice: "Se ha borrado #{@mami.name}."
    else
      flash.now[:error] = "No se puede eliminar."
      render :edit
    end
  end

  protected

    def mami_params
      params.require(:mami).permit(:name, :email, :phone)
    end
end
