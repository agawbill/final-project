class CreateLists < ActiveRecord::Migration[5.2]
  def change
    create_table :lists do |t|
      t.string :name
      t.text :movie_ids, default: [].to_yaml
      t.integer :user_id
      t.boolean :private, default: false

      t.timestamps
    end
  end
end
