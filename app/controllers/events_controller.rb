class EventsController < ApplicationController

  def index
    @recents = Event.open.limit(4)
    @events = Event.where.not(id: @recents.map(&:id)).order(created_at: :desc)
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    @event.user = current_user

    if @event.save
      redirect_to events_path, notice: "Evento creado exitosamente."
    else
      flash.now[:error] = "Debes corregir los datos ingresados."
      render :new
    end
  end

  def edit
    @event = Event.find(params[:id])
    if @event.completed?
      redirect_to @event
    end
  end

  def update
    @event = Event.find(params[:id])

    if @event.update_attributes(event_params)
      redirect_to @event
    else
      flash.now[:error] = "Debes corregir los datos ingresados."
      render :edit
    end
  end

  def show
    @event = Event.find(params[:id])
  end

  def destroy
    @event = Event.find(params[:id])
    if @event.completed?
      redirect_to @event
    end

    if @event.destroy
      redirect_to events_path, notice: "Se ha borrado el evento #{@event.name}"
    else
      flash.now[:error] = "No se puede eliminar este evento."
      render :edit
    end
  end

  protected

    def event_params
      params.require(:event).permit(:name, :goal, :description, :ticket_price, :avatar_url)
    end
end
