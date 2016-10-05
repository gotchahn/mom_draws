class CreateMamis < ActiveRecord::Migration
  def change
    create_table :mamis do |t|
      t.text :name
      t.text :email
      t.text :phone

      t.timestamps null: false
    end
  end
end
