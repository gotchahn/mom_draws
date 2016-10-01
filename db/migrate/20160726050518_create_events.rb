class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.text :name
      t.text :description
      t.integer :ticket_id
      t.datetime :completed_at
      t.decimal :goal
      t.decimal :ticket_price
      t.references :user, index: true, foreign_key: true
      t.string :avatar_url

      t.timestamps null: false
    end
  end
end
