class CreateSettingSls < ActiveRecord::Migration
  def change
    create_table :setting_sls do |t|
      t.integer :num_of_item_per_page

      t.timestamps
    end
  end
end
