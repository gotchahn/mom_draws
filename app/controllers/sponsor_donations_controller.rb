class SponsorDonationsController < ApplicationController
  def index
    @event = Event.find(params[:event_id])
    @donations = @event.sponsor_donations
  end

  def new
    @event = Event.find(params[:event_id])
    @donation = @event.sponsor_donations.build
  end

  def create
    @event = Event.find(params[:event_id])
    @donation = @event.sponsor_donations.build(donation_params)

    if @donation.save
      redirect_to event_sponsor_donations_path, notice: "Donación agregada con éxito."
    else
      flash.now[:error] = "Debes corregir los datos ingresados."
      render :new
    end
  end

  def edit
    @event = Event.find(params[:event_id])
    @donation = @event.sponsor_donations.find(params[:id])
  end

  def update
    @event = Event.find(params[:event_id])
    @donation = @event.sponsor_donations.find(params[:id])

    if @donation.update_attributes(donation_params)
      redirect_to event_sponsor_donations_path, notice: "Donación actualizada."
    else
      flash.now[:error] = "Debes corregir los datos ingresados."
      render :edit
    end
  end

  def destroy
    @event = Event.find(params[:event_id])
    @donation = @event.sponsor_donations.find(params[:id])

    if @donation.destroy
      redirect_to event_sponsor_donations_path, notice: "Donación eliminada."
    else
      redirect_to event_sponsor_donations_path, notice: "No se puede eliminar donación."
    end
  end

  protected

    def donation_params
      params.require(:sponsor_donation).permit(:sponsor_id, :description, :amount)
    end
end
