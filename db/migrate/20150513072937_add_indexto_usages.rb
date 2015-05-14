class AddIndextoUsages < ActiveRecord::Migration
  def change
    add_index :usages, [:usage_type, :user_name, :created_at]
  end
end
