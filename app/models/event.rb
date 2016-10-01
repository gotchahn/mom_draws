class Event < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :name, :goal, :ticket_price

  scope :completed, -> {where.not(completed_at: nil).order(created_at: :desc)}
  scope :open, -> {where(completed_at: nil).order(created_at: :desc)}

  def tickets
    []
  end

  def completed?
    completed_at.present?
  end

  def completed_so_far
    total_tickets = goal * 0.5
    (total_tickets/goal) * 100
  end

  def status
    if completed?
      "Disponible"
    else
      "Cerrado"
    end
  end
end