class AddColumnContentToHistories < ActiveRecord::Migration
  def self.up
    
    add_column :histories, :content, :text
    
  end
  
  def self.down
  
    remove_column :histories, :content, :text
    
  end
end
