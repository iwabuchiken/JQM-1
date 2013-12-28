class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.integer :store_id
      t.string :name
      t.integer :price
      t.integer :genre_id
      t.string :yomi
      t.integer :mobile_id

      t.timestamps
    end
  end
end
