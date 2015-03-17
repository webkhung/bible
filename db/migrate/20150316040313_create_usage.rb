class CreateUsage < ActiveRecord::Migration
  def change
    create_table :usages do |t|
      t.string :user_id
      t.string :ip
      t.string :usage_type
      t.integer :plan_id
      t.integer :day
      t.timestamps null: false
    end
  end
end
