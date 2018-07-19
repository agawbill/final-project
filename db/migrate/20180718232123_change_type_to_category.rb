class ChangeTypeToCategory < ActiveRecord::Migration[5.2]
  def change
    rename_column :lists, :type, :category
  end
end
