class CreateEnvNr4s < ActiveRecord::Migration
  def change
    create_table :env_nr4s do |t|
      t.integer :sort_genre
      t.integer :sort_category
      t.integer :genre_id
      t.integer :category_id

      t.timestamps
    end
  end
end
