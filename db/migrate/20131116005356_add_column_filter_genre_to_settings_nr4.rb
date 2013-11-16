class AddColumnFilterGenreToSettingsNr4 < ActiveRecord::Migration
  def up
      
      add_column :settings_nr4s, :filter_genre, :integer
      add_column :settings_nr4s, :filter_category, :integer

  
  end
  
  def down
      
      remove_column :settings_nr4s, :filter_genre, :integer
      remove_column :settings_nr4s, :filter_category, :integer
      
  end
end
