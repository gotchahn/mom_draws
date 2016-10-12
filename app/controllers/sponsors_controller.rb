class SponsorsController < ApplicationController
  def index
    @sponsors = Sponsor.availables
  end

  def show
    @sponsor = Sponsor.find(params[:id])
  end

  def new
    @sponsor = Sponsor.new
  end

  def create
    @sponsor = Sponsor.new(sponsor_params)

    if @sponsor.save
      redirect_to sponsors_path, notice: "Se ha agregado la Sponsor exitosamente."
    else
      flash.now[:error] = "Debes corregir los datos ingresados."
      render :new
    end
  end

  def edit
    @sponsor = Sponsor.find(params[:id])
  end

  def update
    @sponsor = Sponsor.find(params[:id])

    if @sponsor.update_attributes(sponsor_params)
      redirect_to sponsors_path, notice: "Se ha editado la Sponsor exitosamente."
    else
      flash.now[:error] = "Debes corregir los datos ingresados."
      render :edit
    end
  end

  def destroy
    @sponsor = Sponsor.find(params[:id])

    if @sponsor.destroy
      redirect_to sponsors_path, notice: "Se ha borrado #{@sponsor.name}."
    else
      flash.now[:error] = "No se puede eliminar."
      render :edit
    end
  end

  protected

    def sponsor_params
      params.require(:sponsor).permit(:name, :email, :phone)
    end
end
