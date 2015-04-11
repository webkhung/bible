class AddUserNameToUsages < ActiveRecord::Migration
  def change
    add_column :usages, :user_name, :string
  end
end
