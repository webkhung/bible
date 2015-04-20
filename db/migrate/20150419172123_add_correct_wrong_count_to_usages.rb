class AddCorrectWrongCountToUsages < ActiveRecord::Migration
  def change
    add_column :usages, :details, :string
  end
end
