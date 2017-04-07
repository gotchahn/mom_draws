class ExpensesController < ApplicationController
  def index
    @event = Event.find(params[:event_id])
    @expenses = @event.expenses
  end

  def new
    @event = Event.find(params[:event_id])
    @expense = @event.expenses.build
  end

  def create
    @event = Event.find(params[:event_id])
    @expense = @event.expenses.build(expense_params)

    if @expense.save
      redirect_to event_expenses_path, notice: "Gasto agregada con éxito."
    else
      flash.now[:error] = "Debes corregir los datos ingresados."
      render :new
    end
  end

  def edit
    @event = Event.find(params[:event_id])
    @expense = @event.expenses.find(params[:id])
  end

  def update
    @event = Event.find(params[:event_id])
    @expense = @event.expenses.find(params[:id])

    if @expense.update_attributes(expense_params)
      redirect_to event_expenses_path, notice: "Gasto actualizado."
    else
      flash.now[:error] = "Debes corregir los datos ingresados."
      render :edit
    end
  end

  def destroy
    @event = Event.find(params[:event_id])
    @expense = @event.expenses.find(params[:id])

    if @expense.destroy
      redirect_to event_expenses_path, notice: "Gasto eliminado."
    else
      redirect_to event_expenses_path, notice: "No se puede eliminar el Gasto."
    end
  end

  protected

    def expense_params
      params.require(:expense).permit(:description, :amount)
    end
end
