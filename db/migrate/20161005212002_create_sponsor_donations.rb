class CreateSponsorDonations < ActiveRecord::Migration
  def change
    create_table :sponsor_donations do |t|
      t.references :sponsor, index: true, foreign_key: true
      t.text :description
      t.decimal :amount
      t.references :event, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
