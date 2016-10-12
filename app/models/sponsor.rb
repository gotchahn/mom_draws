class Sponsor < ActiveRecord::Base
  validates_presence_of :name, :email
  validates_uniqueness_of :email

  has_many :sponsor_donations, -> { order(created_at: :desc) }

  scope :availables, -> {where(deleted_at: nil).order(:name)}

  def destroy
    self.deleted_at = Date.current
    save
  end
end
