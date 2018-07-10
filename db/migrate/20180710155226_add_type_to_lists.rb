class AddTypeToLists < ActiveRecord::Migration[5.2]
  def change
    add_column :lists, :type, :string
  end
end
