class SponsorDonation < ActiveRecord::Base
  validates_presence_of :amount, :description, :sponsor_id
  validates_numericality_of :amount, greater_than: 0

  belongs_to :sponsor
  belongs_to :event

  def self.monto_total
    all.sum(:amount)
  end
end
