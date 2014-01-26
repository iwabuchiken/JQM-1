class CreateNlps < ActiveRecord::Migration
  def change
    create_table :nlps do |t|
      t.text :kanji
      t.text :hira
      t.text :kata
      t.text :misc

      t.timestamps
    end
  end
end
