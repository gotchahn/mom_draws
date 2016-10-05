class ChangeMamiTableName < ActiveRecord::Migration
  def change
    rename_table :mamis, :sponsors
  end
end
