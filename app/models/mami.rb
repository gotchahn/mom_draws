class Mami < ActiveRecord::Base
  validates_presence_of :name, :email
  validates_uniqueness_of :email

  scope :availables, -> {where(deleted_at: nil).order(:name)}

  def destroy
    self.deleted_at = Date.current
    save
  end
end
