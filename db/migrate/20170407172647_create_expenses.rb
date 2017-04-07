class CreateExpenses < ActiveRecord::Migration
  def change
    create_table :expenses do |t|
      t.references :event, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.decimal :amount
      t.text :description

      t.timestamps null: false
    end
  end
end
