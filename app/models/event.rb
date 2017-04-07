class Event < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :name, :goal, :ticket_price
  validates_numericality_of :goal, :ticket_price, greater_than: 0

  scope :completed, -> {where.not(completed_at: nil).order(created_at: :desc)}
  scope :open, -> {where(completed_at: nil).order(created_at: :desc)}

  has_many :sponsor_donations, -> { order(created_at: :desc) }
  has_many :expenses, ->{ order(created_at: :desc) }

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

  def avatar
    avatar_url.present? ? avatar_url : "noimage.jpg"
  end
end
