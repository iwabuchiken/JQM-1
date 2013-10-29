class CreateKeywords < ActiveRecord::Migration
  def change
    create_table :keywords do |t|
      t.string :name
      t.integer :genre_id
      t.integer :category_id

      t.timestamps
    end
  end
end
