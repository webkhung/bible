class CreateChat < ActiveRecord::Migration
  def change
    create_table :chats do |t|
      t.string :user_id
      t.string :user_name
      t.text :text
      t.integer :plan_id
      t.integer :day
      t.timestamps null: false
    end

    add_index :chats, [:plan_id, :day, :created_at]
    add_index :chats, [:created_at]
  end
end
