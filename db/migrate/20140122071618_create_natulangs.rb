class CreateNatulangs < ActiveRecord::Migration
  def change
    create_table :natulangs do |t|
      t.text :kanji
      t.text :hira
      t.text :kata
      t.text :misc
      t.integer :history_id

      t.timestamps
    end
  end
end
