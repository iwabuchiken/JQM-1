class CreateHistories < ActiveRecord::Migration
  def change
    create_table :histories do |t|
      t.text :line
      t.string :url
      t.string :vendor
      t.string :news_time
      t.string :genre
      t.string :cat
      t.string :subcat

      t.timestamps
    end
  end
end
