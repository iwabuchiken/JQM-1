class CreateKeyWordSets < ActiveRecord::Migration
  def change
    create_table :key_word_sets do |t|
      t.string :genre
      t.string :category
      t.text :keywords

      t.timestamps
    end
  end
end
