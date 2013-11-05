class CreateSettingsNr4s < ActiveRecord::Migration
  def change
    create_table :settings_nr4s do |t|
      t.integer :sort_genre
      t.integer :sort_category

      t.timestamps
    end
  end
end
