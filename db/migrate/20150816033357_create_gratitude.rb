class CreateGratitude < ActiveRecord::Migration
  def change
    create_table :gratitudes do |t|
      t.string :user_id
      t.string :user_name
      t.text :text
      t.timestamps null: false
    end
  end
end
