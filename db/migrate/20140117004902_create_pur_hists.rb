class CreatePurHists < ActiveRecord::Migration
  def change
    create_table :pur_hists do |t|
      t.text :item_ids
      t.string :pur_date
      t.integer :store_id

      t.timestamps
    end
  end
end
