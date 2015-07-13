class CreateCache < ActiveRecord::Migration
  def change
    create_table :caches do |t|
      t.string :passage
      t.text :text
    end
  end
end
