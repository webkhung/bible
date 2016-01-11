class CreateFavorites < ActiveRecord::Migration
  def change
    create_table :favorites do |t|
      t.string :user_id
      t.string :user_name
      t.integer :plan_id
      t.integer :day
      t.timestamps null: false
    end

    add_index :favorites, [:user_id, :user_name, :plan_id, :day]
    add_index :favorites, [:plan_id, :day]
  end
end
