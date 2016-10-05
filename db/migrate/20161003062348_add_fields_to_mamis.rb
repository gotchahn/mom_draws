class AddFieldsToMamis < ActiveRecord::Migration
  def change
    add_column :mamis, :deleted_at, :datetime
  end
end
