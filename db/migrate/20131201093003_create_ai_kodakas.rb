class CreateAiKodakas < ActiveRecord::Migration
  def change
    create_table :ai_kodakas do |t|
      t.text :line
      t.text :cut_morph
      t.integer :page

      t.timestamps
    end
  end
end
