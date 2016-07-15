class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :name
      t.text :password_digest
      t.string :role

      t.timestamps null: false
    end
  end
end
