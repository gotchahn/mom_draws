class Expense < ActiveRecord::Base
  belongs_to :event
  belongs_to :user

  def self.monto_total
    all.sum(:amount)
  end
end
