class AddAdminToPictures < ActiveRecord::Migration[5.2]
  def change
    add_column :pictures, :admin_id, :integer
  end
end
