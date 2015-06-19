class AddIndexToUsages < ActiveRecord::Migration
  def change
    add_index :usages, [:usage_type, :created_at, :details]
  end
end
